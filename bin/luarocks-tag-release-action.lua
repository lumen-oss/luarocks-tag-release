local function assert_api_key_present()
  if not os.getenv('LUX_API_KEY') and not os.getenv('LUAROCKS_API_KEY') then
    error('LUX_API_KEY secret not set.')
  end
end

local function warn_deprecated_api_key()
  if not os.getenv('LUX_API_KEY') then
    print('::warning::LUAROCKS_API_KEY is deprecated; please use LUX_API_KEY instead.')
  end
end

assert_api_key_present()
warn_deprecated_api_key()

local Parser = require('ltr.parser')
local OS = require('ltr.os')

local function getenv_or_err(env_var)
  return assert(os.getenv(env_var), env_var .. ' not set.')
end

local function getenv_or_empty(env_var)
  return os.getenv(env_var) or ''
end

local github_repo = os.getenv('GITHUB_REPOSITORY_OVERRIDE') or getenv_or_err('GITHUB_REPOSITORY')

local repo_name = assert(
  string.match(github_repo, '/(.+)'),
  [[
    Could not determine repository name from GITHUB_REPOSITORY.
    If you see this, please report this as a bug.
  ]]
)

local git_server_url = os.getenv('GIT_SERVER_URL_OVERRIDE') or getenv_or_err('GITHUB_SERVER_URL')

local is_pull_request = getenv_or_empty('GITHUB_EVENT_NAME') == 'pull_request'

local license_input = os.getenv('INPUT_LICENSE')
local template_input = os.getenv('INPUT_TEMPLATE')
local package_name = getenv_or_err('INPUT_NAME')
---@type string | nil
local package_version = is_pull_request and '0.0.0' or os.getenv('INPUT_VERSION')

---@type Args
local args = {
  github_repo = github_repo,
  repo_name = repo_name,
  git_server_url = git_server_url,
  dependencies = Parser.parse_list_args(getenv_or_empty('INPUT_DEPENDENCIES')),
  test_dependencies = Parser.parse_list_args(getenv_or_empty('INPUT_TEST_DEPENDENCIES')),
  labels = Parser.parse_list_args(getenv_or_empty('INPUT_LABELS')),
  copy_directories = OS.filter_existing_directories(
    Parser.parse_copy_directory_args(getenv_or_err('INPUT_COPY_DIRECTORIES'))
  ),
  summary = getenv_or_empty('INPUT_SUMMARY'),
  detailed_description_lines = Parser.parse_list_args(getenv_or_empty('INPUT_DETAILED_DESCRIPTION')),
  upload = not is_pull_request,
  license = license_input ~= '' and license_input or nil,
  template = template_input ~= '' and template_input or nil,
  extra_luarocks_args = Parser.parse_list_args(getenv_or_empty('INPUT_EXTRA_LUAROCKS_ARGS')),
  extra_lux_args = Parser.parse_list_args(getenv_or_empty('INPUT_EXTRA_LUX_ARGS')),
  github_event_path = getenv_or_err('GITHUB_EVENT_PATH'),
  ref_type = os.getenv('GITHUB_REF_TYPE_OVERRIDE') or getenv_or_err('GITHUB_REF_TYPE'),
  git_ref = os.getenv('GITHUB_REF_NAME_OVERRIDE') or getenv_or_err('GITHUB_REF_NAME'),
  is_debug = os.getenv('RUNNER_DEBUG') == '1',
  fail_on_duplicate = getenv_or_empty('INPUT_FAIL_ON_DUPLICATE') == 'true',
}

local function warn_deprecated_extra_luarocks_args(parsed_args)
  if #parsed_args.extra_luarocks_args > 0 then
    print('::warning::extra_luarocks_args is deprecated; please use extra_lux_args instead.')
  end
end

local function warn_deprecated_test_dependencies(parsed_args)
  if #parsed_args.test_dependencies > 0 then
    print('::warning::test_dependencies is deprecated and is no longer published to the rockspec.')
  end
end

warn_deprecated_extra_luarocks_args(args)
warn_deprecated_test_dependencies(args)

local function get_github_sha()
  return os.getenv('GITHUB_SHA_OVERRIDE') or getenv_or_err('GITHUB_SHA')
end

print('Workflow has been triggered by: ' .. args.ref_type)
local is_tag = args.ref_type == 'tag'
if not is_tag then
  print('Publishing an untagged release.')
  args.git_ref = get_github_sha()
end

local luarocks_tag_release = require('luarocks-tag-release')

if is_pull_request then
  print('Running in a pull request.')
  args.git_ref = get_github_sha()
end

luarocks_tag_release(package_name, package_version, args)
