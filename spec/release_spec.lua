describe('Release', function()
  local Release = require('ltr.release')

  local function base_meta()
    return {
      ref_type = 'tag',
      git_server_url = 'https://github.com',
      github_repo = 'owner/repo',
      summary = '',
      detailed_description_lines = {},
      dependencies = {},
      test_dependencies = {},
      labels = {},
      copy_directories = {},
      repo_name = 'repo',
    }
  end

  it('Falls back to the repository URL without event metadata', function()
    local release = Release.resolve(base_meta())
    assert.are.same('https://github.com/owner/repo', release.repo_url)
    assert.are.same('https://github.com/owner/repo', release.homepage)
    assert.are.same(nil, release.license)
    assert.are.same({}, release.labels)
  end)

  it('Resolves metadata from the GitHub event', function()
    local meta = base_meta()
    meta.github_event = {
      repository = {
        description = 'from the repository',
        homepage = 'https://example.com',
        topics = { 'neovim' },
        license = { spdx_id = 'MIT' },
      },
    }
    local release = Release.resolve(meta)
    assert.are.same('from the repository', release.summary)
    assert.are.same({ 'neovim' }, release.labels)
    assert.are.same('MIT', release.license)
    assert.are.same('https://example.com', release.homepage)
  end)

  it('Prefers an explicit license input', function()
    local meta = base_meta()
    meta.license = 'AGPL3'
    meta.github_event = { repository = { license = { spdx_id = 'MIT' } } }
    assert.are.same('AGPL3', Release.resolve(meta).license)
  end)

  it('Errors when no license can be determined', function()
    local meta = base_meta()
    meta.github_event = { repository = { license = { spdx_id = 'NOASSERTION' } } }
    assert.is_false(pcall(Release.resolve, meta))
  end)

  it('Uses the pull request head repository when present', function()
    local meta = base_meta()
    meta.github_event = {
      pull_request = { head = { repo = { description = 'pr repo', license = { spdx_id = 'MIT' } } } },
      repository = { description = 'base', license = { spdx_id = 'Apache-2.0' } },
    }
    local release = Release.resolve(meta)
    assert.are.same('pr repo', release.summary)
    assert.are.same('MIT', release.license)
  end)
end)
