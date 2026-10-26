<!-- markdownlint-disable -->
<br />
<div align="center">
  <a href="https://github.com/nvim-neorocks/luarocks-tag-release">
    <img src="https://avatars.githubusercontent.com/u/124081866?s=400&u=0da379a468d46456477a1f68048b020cf7a99f34&v=4" alt="neorocks">
  </a>
  <p align="center">
    <a href="https://github.com/nvim-neorocks/luarocks-tag-release/issues">Report Bug</a>
  </p>
  <p>
    <strong>
      luarocks-tag-release
      <br />
      Automatically publish <a href="https://luarocks.org/">luarocks</a> packages from git tags.
      <br />
      Designed to work with <a href="https://neovim.io/">Neovim</a> plugins.
    </strong>
  </p>
  <p>🏷️🚀🌒</p>
</div>
<!-- markdownlint-restore -->

[![Neovim][neovim-shield]][neovim-url]
[![Lua][lua-shield]][lua-url]
[![AGPL3 License][license-shield]][license-url]
[![Issues][issues-shield]][issues-url]
[![Luarocks release][ci-shield]][ci-url]

> [!TIP]
>
> We recommend switching to [gh-actions-lux](https://github.com/lumen-oss/gh-actions-lux/).

Publishes packages to [LuaRocks](https://luarocks.org/) when a git tag is pushed.
No need to add a rockspec to your repository for each release (or at all).

## Quick links

- [Features](#features)
- [Prerequisites](#prerequisites)
- [Usage](#usage)
- [Inputs](#inputs)
- [Example configurations](https://github.com/nvim-neorocks/luarocks-tag-release/wiki/Example-configurations)
- [Limitations](#limitations)
- [Related](#related)
- [Acknowledgements](#acknowledgements)

## Features

- Generates a [lux.toml](https://lux.lumen-labs.org/reference/lux-toml) from repository metadata
  and action inputs, unless the repository already provides a `lux.toml`.
- Tests a local installation from the generated rockspec before uploading.
- Uploads the package to LuaRocks using [lux](https://lux.lumen-labs.org/).
- Tests the installation of the uploaded package.

## Prerequisites

- A LuaRocks account and an [API key](https://luarocks.org/settings/api-keys).
- Add the API key to your [repository's GitHub Actions secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets#creating-encrypted-secrets-for-a-repository) as `LUX_API_KEY`.

## Usage

Create `.github/workflows/release.yml` in your repository with the following contents:

```yaml
name: LuaRocks release
on:
  push:
    tags: # Will upload to luarocks.org when a tag is pushed
      - "*"
  pull_request: # Will test a local install without uploading to luarocks.org

jobs:
  luarocks-release:
    runs-on: ubuntu-latest
    name: LuaRocks upload
    steps:
      - name: Checkout
        uses: actions/checkout@v3
      - name: LuaRocks Upload
        uses: nvim-neorocks/luarocks-tag-release@v9
        env:
          LUX_API_KEY: ${{ secrets.LUX_API_KEY }}
```

> [!NOTE]
>
> Use the `v9` tag to keep up with the latest releases, without breaking changes.

## Inputs

The following optional inputs can be specified using `with:`

### `name`

The name of the the luarocks package.

- Defaults to the repository name.

### `dependencies`

Lua dependencies, added to the generated project with `lx add`.
Any dependencies specified here must be available on LuaRocks.

> [!NOTE]
>
> lux requires an explicit version requirement for each dependency.
> Bare names (e.g. `plenary.nvim`) are resolved by lux to the latest version at publish time.
> This may change in the future (see [lux#2011](https://github.com/lumen-oss/lux/issues/2011)).
>
> A `lua` entry (e.g. `lua >= 5.4`) sets the published Lua version constraint
> and is not added as a dependency.

Example:

```yaml
- name: LuaRocks Upload
  uses: nvim-neorocks/luarocks-tag-release@v9
  with:
    dependencies: |
      plenary.nvim
      telescope.nvim
```

### `labels`

Labels to add to the rockspec.
If none are specified, this action will use the repository's GitHub topics.

Example:

```yaml
- name: LuaRocks Upload
  uses: nvim-neorocks/luarocks-tag-release@v9
  with:
    labels: |
      neovim
```

### `copy_directories`

Directories in the source directory to be copied to the rock installation
prefix as-is.
Useful for installing documentation and other files such as samples and tests.

Example:

```yaml
- name: LuaRocks Upload
  uses: nvim-neorocks/luarocks-tag-release@v9
  with:
    copy_directories: |
      {{ neovim.plugin.dirs }}
      src
      examples
```

>[!NOTE]
>
> The value `{{ neovim.plugin.dirs }}` (set by default)
> expands to common Neovim plugin directories (see also `:help runtimepath`):
>
> - autoload
> - colors
> - compiler
> - doc
> - filetype.lua
> - ftdetect
> - ftplugin
> - indent
> - keymap
> - lang
> - lsp
> - menu.vim
> - parser
> - plugin
> - queries
> - query
> - rplugin
> - spell
> - syntax

<!-- markdownlint-disable -->
>[!WARNING]
>
> Do not use the following directory names: `lua`, `lib`, `rock_manifest`
> or the name of your rockspec; those names are used by the .rock format
> internally, and attempting to copy directories with those names using
> the build.copy_directories directive will cause a clash.
<!-- markdownlint-restore -->

### `summary`

A short description of the package (one line).
If excluded, this action will fetch it from your repository's about section.

### `detailed_description`

A more detailed description of the package. Can be multiple lines.

Example:

```yaml
- name: LuaRocks Upload
  uses: nvim-neorocks/luarocks-tag-release@v9
  with:
    detailed_description: |
      Publishes packages to LuaRocks when a git tag is pushed.
      Automatically generates a rockspec from repository metadata
      and tests the installation before releasing.
```

### `template`

Path to a custom [`extra.rockspec`](https://lux.lumen-labs.org/guides/rockspec).

Use this to customise the generated project's build specification, dependencies,
or other fields that cannot be expressed through the action inputs.
lux merges the `extra.rockspec` over the generated `lux.toml`.

Example:

```yaml
- name: LuaRocks Upload
  uses: nvim-neorocks/luarocks-tag-release@v9
  with:
    template: "/path/to/my/extra.rockspec"
```

> [!WARNING]
>
> An `extra.rockspec` must not define `version` or `source`
> (those are generated by the action), and the `$placeholder` templating
> from earlier versions of luarocks-tag-release no longer applies.

### `license` (optional)

The license used by this package.
If not set (by default), this workflow will fetch the license SPDX ID from GitHub.
If GitHub cannot detect the license automatically, you can set it here.

Example:

```yaml
- name: LuaRocks Upload
  uses: nvim-neorocks/luarocks-tag-release@v9
  with:
    license: "MIT"
```

> [!NOTE]
>
> If GitHub can detect the license automatically,
> it will be displayed in your repository's About section.
>
> ![about](https://user-images.githubusercontent.com/12857160/218101570-b0605716-0457-47c1-ab2e-91d48a48881c.png)

### `version` (optional)

The version to publish (without the rockspec revision).

By default, [lux](https://lux.lumen-labs.org/) derives the version from the git tag
(a leading `v` is stripped). If there is no SemVer tag, a `dev` version is published.

Set this input to publish a specific version, for example from a scheduled workflow
that has no tags. Setting it to `"scm"` or `"dev"` publishes a dev release.

The `specrev` input has been removed; lux manages the rockspec revision automatically.

Example:

```yaml
- name: LuaRocks Upload
  uses: nvim-neorocks/luarocks-tag-release@v9
  with:
    version: "0.0.123"
```

### `fail_on_duplicate` (optional)

When set to `true` will cause the workflow to fail with an error if the rock already exists on the server.
By default, if the rock already exists with a given version, the workflow will do nothing and fall back to other tasks
instead (e.g. running tests).

### `lua_version` (optional)

The Lua version this action builds, tests and publishes with.
Defaults to `5.1`.

Example:

```yaml
- name: LuaRocks Upload
  uses: nvim-neorocks/luarocks-tag-release@v9
  with:
    lua_version: "5.4"
```

> [!NOTE]
>
> This only chooses the interpreter the package is tested against.
> The published Lua version constraint is a separate setting
> (see the `lua` entry of the `dependencies` input).

### `lux_version` (optional)

The [lux](https://lux.lumen-labs.org/) version installed and run by this action.
Defaults to `0.49.3`.

Example:

```yaml
- name: LuaRocks Upload
  uses: nvim-neorocks/luarocks-tag-release@v9
  with:
    lux_version: "0.47.0"
```

### `extra_lux_args`

Extra arguments passed to the lux command.

Example:

```yaml
- run: |
    sudo apt-get install -y libcurl4-openssl-dev
- name: LuaRocks Upload
  uses: nvim-neorocks/luarocks-tag-release@v9
  with:
    extra_lux_args: |
      --lua-version 5.4 --variables CURL_INCDIR=/usr/include/x86_64-linux-gnu
```

> [!TIP]
>
> To find out where `apt` installs headers
> (assuming you are have set `runs-on: ubuntu-xyz`),
> you can run `dpkg -L <package-name>`.

### `gpg_private_key` (optional)

An ASCII-armoured GPG private key used to sign the uploaded rockspec.
When unset, uploads are not signed.

Example:

```yaml
- name: LuaRocks Upload
  uses: nvim-neorocks/luarocks-tag-release@v9
  with:
    gpg_private_key: ${{ secrets.GPG_PRIVATE_KEY }}
    gpg_passphrase: ${{ secrets.GPG_PASSPHRASE }}
```

### `gpg_passphrase` (optional)

The passphrase for `gpg_private_key`, if one is set.

### `sign_protocol` (optional)

The GPG signing protocol used by lux when a key is provided.
Defaults to `default`. Ignored when `gpg_private_key` is unset.

## Example configurations

See the [Example configurations wiki page](https://github.com/nvim-neorocks/luarocks-tag-release/wiki/Example-configurations).

## Limitations

- This workflow only works on public repositories.
- The published Lua version constraint defaults to `>= 5.1`.
  To change it, add a `lua` entry to the `dependencies` input (e.g. `lua >= 5.4`)
  or set the Lua constraint in your project's `lux.toml`.
- To build/install with a Lua version other than the one selected by `lua_version`
  (e.g. testing several versions with one interpreter), pass
  `extra_lux_args: --lua-version <version>`.

## Related

- [`rocks.nvim`](https://github.com/nvim-neorocks/rocks.nvim):
  A modern approach to Neovim plugin management, which uses
  luarocks.
- [Luarocks :purple_heart: Neovim](https://github.com/nvim-neorocks/sample-luarocks-plugin):
  A simple sample repository showing how to push your Neovim plugins to luarocks.

## Acknowledgements

Thanks to:

- [@Conni2461](https://github.com/Conni2461) for the help debugging the first drafts.
- The [neorocks](https://github.com/nvim-neorocks) surgeons:
  - [**@teto**](https://github.com/teto)
  - [**@vhyrro**](https://github.com/vhyrro)
  - [**@NTBBloodbath**](https://github.com/NTBBloodbath)
  - [**@vigoux**](https://github.com/vigoux)
  - [**@vsedov**](https://github.com/vsedov)
  - [**@mrcjkb**](https://github.com/mrcjkb)

<!-- MARKDOWN LINKS & IMAGES -->
[neovim-shield]: https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white
[neovim-url]: https://neovim.io/
[lua-shield]: https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white
[lua-url]: https://www.lua.org/
[issues-shield]: https://img.shields.io/github/issues/nvim-neorocks/luarocks-tag-release.svg?style=for-the-badge
[issues-url]: https://github.com/nvim-neorocks/luarocks-tag-release/issues
[license-shield]: https://img.shields.io/github/license/nvim-neorocks/luarocks-tag-release.svg?style=for-the-badge
[license-url]: https://github.com/nvim-neorocks/luarocks-tag-release/blob/master/LICENSE
[ci-shield]: https://img.shields.io/github/actions/workflow/status/nvim-neorocks/luarocks-tag-release/nix-build.yml?style=for-the-badge
[ci-url]: https://github.com/nvim-neorocks/luarocks-tag-release/actions/workflows/nix-build.yml
