local Release = {}

---@class GithubLicense
---@field spdx_id string

---@class GithubRepository
---@field description? string
---@field homepage? string
---@field topics? string[]
---@field license? GithubLicense
---@field source? { license?: GithubLicense }

---@class GithubEvent
---@field repository? GithubRepository
---@field pull_request? { head?: { repo?: GithubRepository } }

local on_missing_license = [[
    Could not get the license SPDX ID from the GitHub API.
    Please add a license file that GitHub can recognise or add a `license` input,
    or specify the license type as a workflow input.
    See: https://github.com/nvim-neorocks/luarocks-tag-release#license
    ]]

---@param event GithubEvent|nil
---@return GithubRepository|nil
local function repo_metadata(event)
  if not event then
    return nil
  end
  if event.pull_request and event.pull_request.head then
    return event.pull_request.head.repo
  end
  return event.repository
end

---@param meta GenerateMeta
---@param repo GithubRepository|nil
---@return string|nil license
local function resolve_license(meta, repo)
  if meta.license then
    return meta.license
  end
  if repo then
    local repo_license = repo.license or repo.source and repo.source.license
    if repo_license and repo_license.spdx_id ~= '' and repo_license.spdx_id ~= 'NOASSERTION' then
      return repo_license.spdx_id
    end
    error(on_missing_license)
  end
  return nil
end

---@param meta GenerateMeta
---@return string
local function repo_url(meta)
  return meta.git_server_url .. '/' .. meta.github_repo
end

---@param repo GithubRepository|nil
---@param summary string
---@return string
local function resolve_summary(repo, summary)
  if repo and (not summary or summary == '') then
    return repo.description or ''
  end
  return summary
end

---@param repo GithubRepository|nil
---@param labels string[]
---@return string[]
local function resolve_labels(repo, labels)
  if repo and #labels == 0 then
    return repo.topics or {}
  end
  return labels
end

---@param repo GithubRepository|nil
---@param default_homepage string
---@return string
local function resolve_homepage(repo, default_homepage)
  if repo and repo.homepage and repo.homepage ~= '' then
    return repo.homepage
  end
  return default_homepage
end

---@class (exact) ResolvedRelease
---@field summary string
---@field labels string[]
---@field license string|nil The license SPDX ID, if any.
---@field homepage string
---@field repo_url string

---Resolve release metadata from the GitHub event and workflow inputs.
---@param meta GenerateMeta
---@return ResolvedRelease
function Release.resolve(meta)
  local repo = repo_metadata(meta.github_event)
  local url = repo_url(meta)
  return {
    summary = resolve_summary(repo, meta.summary),
    labels = resolve_labels(repo, meta.labels),
    license = resolve_license(meta, repo),
    homepage = resolve_homepage(repo, url),
    repo_url = url,
  }
end

return Release
