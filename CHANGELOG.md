<!-- markdownlint-disable MD024 -->

# Changelog

## [7.2.0](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v7.1.0...v7.2.0) (2025-04-13)


### Features

* **neovim:** support `lsp` runtime directory ([#643](https://github.com/nvim-neorocks/luarocks-tag-release/issues/643)) ([da4e090](https://github.com/nvim-neorocks/luarocks-tag-release/commit/da4e090accd58917793aa7116c825d7ea7590754))
* set up luarocks path before test install ([#597](https://github.com/nvim-neorocks/luarocks-tag-release/issues/597)) ([7bc0a20](https://github.com/nvim-neorocks/luarocks-tag-release/commit/7bc0a20c425da1ba577a4ff6b2c56c81e2feb4ca))

## [7.1.0](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v7.0.1...v7.1.0) (2024-06-21)


### Features

* add build backends to release action ([41f04b5](https://github.com/nvim-neorocks/luarocks-tag-release/commit/41f04b5bb45e34a8cc871ea49bb3cca07c7d3da1))

## [7.0.1](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v7.0.0...v7.0.1) (2024-06-21)


### Bug Fixes

* remove luarocks build backends ([#440](https://github.com/nvim-neorocks/luarocks-tag-release/issues/440)) ([78dd246](https://github.com/nvim-neorocks/luarocks-tag-release/commit/78dd24621e61cc569bd028349313fe4ece2ab953))

## [7.0.0](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v6.0.0...v7.0.0) (2024-06-21)


### ⚠ BREAKING CHANGES

* drop support for running tests in favour of nvim-busted-action ([#437](https://github.com/nvim-neorocks/luarocks-tag-release/issues/437))

### Features

* drop support for running tests in favour of nvim-busted-action ([#437](https://github.com/nvim-neorocks/luarocks-tag-release/issues/437)) ([2af6c3a](https://github.com/nvim-neorocks/luarocks-tag-release/commit/2af6c3a00772ee42a161d02a8d324ab53b24bb13))

## [6.0.0](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.14.1...v6.0.0) (2024-06-18)


### ⚠ BREAKING CHANGES

* deprecate `test_interpreters` and disable tests by default

### Features

* deprecate `test_interpreters` and disable tests by default ([906f4b5](https://github.com/nvim-neorocks/luarocks-tag-release/commit/906f4b54130766a3f2691b9cb5a910c39da6a40a))

## [5.14.1](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.14.0...v5.14.1) (2024-06-17)


### Bug Fixes

* add `ftdetect` to `{{ neovim.plugin.dirs }}`. ([#431](https://github.com/nvim-neorocks/luarocks-tag-release/issues/431)) ([9ae4c23](https://github.com/nvim-neorocks/luarocks-tag-release/commit/9ae4c23abc6b08b14c0d456d7c85d718d61f3d90))

## [5.14.0](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.13.1...v5.14.0) (2024-05-25)


### Features

* do not fail on already existing rocks, add `fail_on_duplicate` flag ([#411](https://github.com/nvim-neorocks/luarocks-tag-release/issues/411)) ([07c35cf](https://github.com/nvim-neorocks/luarocks-tag-release/commit/07c35cf0c2a1346dc9484c74a250f1e0c48dede8))

## [5.13.1](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.13.0...v5.13.1) (2024-05-24)


### Bug Fixes

* add --local lua_interpreter luarocks config ([eaece88](https://github.com/nvim-neorocks/luarocks-tag-release/commit/eaece884f51711ca69fbc47b18b8223b961f7589))
* add `--local` flag for test runs ([76057a2](https://github.com/nvim-neorocks/luarocks-tag-release/commit/76057a2ad04a43444c9c5b885251e3b15e7c6dec))
* add `--tree .` to `luarocks init` before running tests ([a5ef7e6](https://github.com/nvim-neorocks/luarocks-tag-release/commit/a5ef7e6400396b4d6858ed788db08ddfb9c2330c))
* don't propagate busted ([8d3bb48](https://github.com/nvim-neorocks/luarocks-tag-release/commit/8d3bb48e456a2227d34ac3e6f0212bb97a86cab9))
* lua_interpreter -&gt; variables.LUA ([9f80ab8](https://github.com/nvim-neorocks/luarocks-tag-release/commit/9f80ab80229effed03116c5a2219e98e0106b072))
* remove busted from propagatedBuildInputs ([0b7b24f](https://github.com/nvim-neorocks/luarocks-tag-release/commit/0b7b24f8feab1928e77c7d07ea1570311ff5f904))


### Reverts

* add `--local` flag for test runs ([b75ae1d](https://github.com/nvim-neorocks/luarocks-tag-release/commit/b75ae1d796ba28ee0079dd3a8dd0db85e1b79e3c))

## [5.13.0](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.12.0...v5.13.0) (2024-05-06)


### Features

* add `specrev` input ([#407](https://github.com/nvim-neorocks/luarocks-tag-release/issues/407)) ([f6d8fb5](https://github.com/nvim-neorocks/luarocks-tag-release/commit/f6d8fb5297a1bcf902cb81c53812ab05110c642c))

## [5.12.0](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.11.2...v5.12.0) (2024-03-27)


### Features

* allow overriding git server URL with `GIT_SERVER_URL_OVERRIDE` ([#402](https://github.com/nvim-neorocks/luarocks-tag-release/issues/402)) ([532117c](https://github.com/nvim-neorocks/luarocks-tag-release/commit/532117c5b322a93c74b20203c890b0e174acd23c))

## [5.11.2](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.11.1...v5.11.2) (2024-03-16)


### Bug Fixes

* **parser:** add missing `after` directory in the Neovim plugin dirs list ([#392](https://github.com/nvim-neorocks/luarocks-tag-release/issues/392)) ([8d3d786](https://github.com/nvim-neorocks/luarocks-tag-release/commit/8d3d78685669c4fac94135c35fa8d8dcee63cd94))

## [5.11.1](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.11.0...v5.11.1) (2024-03-13)


### Reverts

* support LUAROCKS_TAG_RELEASE_DISABLE_UPLOAD environment variable ([437e606](https://github.com/nvim-neorocks/luarocks-tag-release/commit/437e60669818531709e711d00c74caecd2d5f0c9))
* when uploading dev rocks, only upload if the rockspec sha changed ([#381](https://github.com/nvim-neorocks/luarocks-tag-release/issues/381)) ([5598832](https://github.com/nvim-neorocks/luarocks-tag-release/commit/55988321885cf9cbf34eb86efbc76b04e7e18fb5))

## [5.11.0](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.10.0...v5.11.0) (2024-03-11)


### Features

* support LUAROCKS_TAG_RELEASE_DISABLE_UPLOAD environment variable ([a7fb13c](https://github.com/nvim-neorocks/luarocks-tag-release/commit/a7fb13c2e26d99918315530c3ad2fbc0c9ee38da))

## [5.10.0](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.9.1...v5.10.0) (2024-03-10)


### Features

* when uploading dev rocks, only upload if the rockspec sha changed ([#381](https://github.com/nvim-neorocks/luarocks-tag-release/issues/381)) ([a85364b](https://github.com/nvim-neorocks/luarocks-tag-release/commit/a85364bcb0db44e3438432d8a81a323f2ee3acc9))

## [5.9.1](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.9.0...v5.9.1) (2024-03-08)


### Bug Fixes

* lowercase package_name ([467bdfd](https://github.com/nvim-neorocks/luarocks-tag-release/commit/467bdfda255b5074337e70b16a0b098ab02993d2))

## [5.9.0](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.8.0...v5.9.0) (2024-03-07)


### Features

* support "scm" and "dev" versions ([#370](https://github.com/nvim-neorocks/luarocks-tag-release/issues/370)) ([2b77919](https://github.com/nvim-neorocks/luarocks-tag-release/commit/2b7791947011f89b51409c83e89ab4216eb4fa82))

## [5.8.0](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.7.0...v5.8.0) (2024-03-02)


### Features

* add target-server input ([d92cb42](https://github.com/nvim-neorocks/luarocks-tag-release/commit/d92cb42ead6c0ab59c241b08c7eb055e465f329e))
* allow overriding github environment variables ([d852913](https://github.com/nvim-neorocks/luarocks-tag-release/commit/d85291362b288188f250ef64101b362a3f2a176f))


### Bug Fixes

* parentheses ([6846f8f](https://github.com/nvim-neorocks/luarocks-tag-release/commit/6846f8fd88274403539805e08a6842c9efcd74ca))


### Reverts

* add target-server input ([9f49b06](https://github.com/nvim-neorocks/luarocks-tag-release/commit/9f49b06c000943e86ddfed79a4c6a38cff67e8f7))

## [5.7.0](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.6.0...v5.7.0) (2024-02-25)


### Features

* add `parser-info` to `{{ neovim.plugin.dirs }}` ([#357](https://github.com/nvim-neorocks/luarocks-tag-release/issues/357)) ([bbc7eb7](https://github.com/nvim-neorocks/luarocks-tag-release/commit/bbc7eb7deffea5f9ce40a3b1ea2a225cd91fa7a5))

## [5.6.0](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.5.0...v5.6.0) (2024-02-22)


### Features

* support passing in extra luarocks args ([#351](https://github.com/nvim-neorocks/luarocks-tag-release/issues/351)) ([567a8d2](https://github.com/nvim-neorocks/luarocks-tag-release/commit/567a8d26f3125c9c6d928ad275e0765ff5e3e1d2))

## [5.5.0](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.4.1...v5.5.0) (2024-02-22)


### Features

* test_dependencies input ([#349](https://github.com/nvim-neorocks/luarocks-tag-release/issues/349)) ([71e64ab](https://github.com/nvim-neorocks/luarocks-tag-release/commit/71e64ab8ffae25b6803f2c737a3da8d931595163))

## [5.4.1](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.4.0...v5.4.1) (2024-02-08)


### Bug Fixes

* `luarocks test` not picking up neovim as a lua interpreter ([#334](https://github.com/nvim-neorocks/luarocks-tag-release/issues/334)) ([5837397](https://github.com/nvim-neorocks/luarocks-tag-release/commit/5837397ce6ed963858d48a6b8bfa492f142a9946))

## [5.4.0](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.3.14...v5.4.0) (2024-02-05)


### Features

* suppress nix profile-install output ([#328](https://github.com/nvim-neorocks/luarocks-tag-release/issues/328)) ([bac476b](https://github.com/nvim-neorocks/luarocks-tag-release/commit/bac476b1fe24684b3429ede197b96601cb6d1f62))

## [5.3.14](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.3.13...v5.3.14) (2023-12-04)


### Dependencies

* update flake.lock ([#263](https://github.com/nvim-neorocks/luarocks-tag-release/issues/263)) ([17d91b7](https://github.com/nvim-neorocks/luarocks-tag-release/commit/17d91b7c767407adfa7a33e7bba3b979238ff961))

## [5.3.13](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.3.12...v5.3.13) (2023-12-03)


### Dependencies

* update flake.lock ([#261](https://github.com/nvim-neorocks/luarocks-tag-release/issues/261)) ([f8b793c](https://github.com/nvim-neorocks/luarocks-tag-release/commit/f8b793c2db4c375e7155e63553828928d8334e1b))

## [5.3.12](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.3.11...v5.3.12) (2023-12-02)


### Dependencies

* update flake.lock ([#259](https://github.com/nvim-neorocks/luarocks-tag-release/issues/259)) ([961731d](https://github.com/nvim-neorocks/luarocks-tag-release/commit/961731dae08cd77f37960d77fb95a5345a5072bf))

## [5.3.11](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.3.10...v5.3.11) (2023-12-01)


### Dependencies

* update flake.lock ([#257](https://github.com/nvim-neorocks/luarocks-tag-release/issues/257)) ([cbab520](https://github.com/nvim-neorocks/luarocks-tag-release/commit/cbab520c088db5789b0b7296f9e3f6e617f35a29))

## [5.3.10](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.3.9...v5.3.10) (2023-11-30)


### Dependencies

* update flake.lock ([#255](https://github.com/nvim-neorocks/luarocks-tag-release/issues/255)) ([667ecfe](https://github.com/nvim-neorocks/luarocks-tag-release/commit/667ecfed5f2b8c3694fb7053f0d786590caa1d11))

## [5.3.9](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.3.8...v5.3.9) (2023-11-29)


### Dependencies

* update flake.lock ([#253](https://github.com/nvim-neorocks/luarocks-tag-release/issues/253)) ([49ded5e](https://github.com/nvim-neorocks/luarocks-tag-release/commit/49ded5e88855abf7f101f25c307b819dd72da4a2))

## [5.3.8](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.3.7...v5.3.8) (2023-11-28)


### Dependencies

* update flake.lock ([#251](https://github.com/nvim-neorocks/luarocks-tag-release/issues/251)) ([aedf16a](https://github.com/nvim-neorocks/luarocks-tag-release/commit/aedf16ac8977f9189ece7d036cc94512224defd8))

## [5.3.7](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.3.6...v5.3.7) (2023-11-27)


### Dependencies

* update flake.lock ([#249](https://github.com/nvim-neorocks/luarocks-tag-release/issues/249)) ([9cc7b26](https://github.com/nvim-neorocks/luarocks-tag-release/commit/9cc7b26faeed6a12066518337c7f6f60a1b946ff))

## [5.3.6](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.3.5...v5.3.6) (2023-11-26)


### Dependencies

* update flake.lock ([#247](https://github.com/nvim-neorocks/luarocks-tag-release/issues/247)) ([1f49c4e](https://github.com/nvim-neorocks/luarocks-tag-release/commit/1f49c4e8bdbf856a223dc503ba36c6a1b7ede830))

## [5.3.5](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.3.4...v5.3.5) (2023-11-25)


### Dependencies

* update flake.lock ([#245](https://github.com/nvim-neorocks/luarocks-tag-release/issues/245)) ([2499234](https://github.com/nvim-neorocks/luarocks-tag-release/commit/249923453f44e9436adf26a993f2ee0189393c9f))

## [5.3.4](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.3.3...v5.3.4) (2023-11-24)


### Dependencies

* update flake.lock ([#243](https://github.com/nvim-neorocks/luarocks-tag-release/issues/243)) ([a4a2177](https://github.com/nvim-neorocks/luarocks-tag-release/commit/a4a21779dab197819b2bf62d351b51688b3069bc))

## [5.3.3](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.3.2...v5.3.3) (2023-11-23)


### Dependencies

* update flake.lock ([#241](https://github.com/nvim-neorocks/luarocks-tag-release/issues/241)) ([64bbe47](https://github.com/nvim-neorocks/luarocks-tag-release/commit/64bbe4714f58d3eebace6fc2edd1f06d1cf849db))

## [5.3.2](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.3.1...v5.3.2) (2023-11-22)


### Dependencies

* update flake.lock ([#239](https://github.com/nvim-neorocks/luarocks-tag-release/issues/239)) ([1904f27](https://github.com/nvim-neorocks/luarocks-tag-release/commit/1904f27d1cf1db08cdd5847221e7e691c3fc9662))

## [5.3.1](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.3.0...v5.3.1) (2023-11-21)


### Dependencies

* update flake.lock ([#237](https://github.com/nvim-neorocks/luarocks-tag-release/issues/237)) ([d2cb92e](https://github.com/nvim-neorocks/luarocks-tag-release/commit/d2cb92e36e8befe3df75796a5bb98db93067f969))

## [5.3.0](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.52...v5.3.0) (2023-11-20)


### Features

* add support for luarocks-build-rust-mlua ([#235](https://github.com/nvim-neorocks/luarocks-tag-release/issues/235)) ([d01493e](https://github.com/nvim-neorocks/luarocks-tag-release/commit/d01493e43d10a1e8c08a0a05af580015d3f5dbd3))

## [5.2.52](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.51...v5.2.52) (2023-11-20)


### Dependencies

* update flake.lock ([#231](https://github.com/nvim-neorocks/luarocks-tag-release/issues/231)) ([abb6e4a](https://github.com/nvim-neorocks/luarocks-tag-release/commit/abb6e4a2a6bdbc824211300d6bc8565b27c79c37))

## [5.2.51](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.50...v5.2.51) (2023-11-17)


### Dependencies

* update flake.lock ([#229](https://github.com/nvim-neorocks/luarocks-tag-release/issues/229)) ([1c844b6](https://github.com/nvim-neorocks/luarocks-tag-release/commit/1c844b68ac4b120c183981f88151ffb8ea1a3d2b))

## [5.2.50](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.49...v5.2.50) (2023-11-16)


### Dependencies

* update flake.lock ([#227](https://github.com/nvim-neorocks/luarocks-tag-release/issues/227)) ([cdad585](https://github.com/nvim-neorocks/luarocks-tag-release/commit/cdad585eea6a42814b9124e3ee85eaa64b85e0eb))

## [5.2.49](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.48...v5.2.49) (2023-11-13)


### Bug Fixes

* name rockspec file using lower case package name ([5c55dc9](https://github.com/nvim-neorocks/luarocks-tag-release/commit/5c55dc95abb6f09937ba3b82429994f17123d600))

## [5.2.48](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.47...v5.2.48) (2023-11-13)


### Dependencies

* update flake.lock ([#224](https://github.com/nvim-neorocks/luarocks-tag-release/issues/224)) ([5e933eb](https://github.com/nvim-neorocks/luarocks-tag-release/commit/5e933eb149ddd11ed75df47177c44d6021d7f1f0))

## [5.2.47](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.46...v5.2.47) (2023-11-12)


### Dependencies

* update flake.lock ([#222](https://github.com/nvim-neorocks/luarocks-tag-release/issues/222)) ([3b8e59c](https://github.com/nvim-neorocks/luarocks-tag-release/commit/3b8e59cc858426ed08271fbdbd4e0b765b30d8e4))

## [5.2.46](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.45...v5.2.46) (2023-11-08)


### Dependencies

* update flake.lock ([#220](https://github.com/nvim-neorocks/luarocks-tag-release/issues/220)) ([7b86f97](https://github.com/nvim-neorocks/luarocks-tag-release/commit/7b86f97e0b1e7c5fa555e53236cdbc63c4b946ab))

## [5.2.45](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.44...v5.2.45) (2023-11-07)


### Dependencies

* update flake.lock ([#218](https://github.com/nvim-neorocks/luarocks-tag-release/issues/218)) ([cbedc70](https://github.com/nvim-neorocks/luarocks-tag-release/commit/cbedc708e3af21e054e518c81e01d9dcba4ec1c4))

## [5.2.44](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.43...v5.2.44) (2023-11-06)


### Dependencies

* update flake.lock ([#216](https://github.com/nvim-neorocks/luarocks-tag-release/issues/216)) ([0187eb3](https://github.com/nvim-neorocks/luarocks-tag-release/commit/0187eb303457eb5f3abc6e9316debee9c060e8b3))

## [5.2.43](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.42...v5.2.43) (2023-11-05)


### Dependencies

* update flake.lock ([#214](https://github.com/nvim-neorocks/luarocks-tag-release/issues/214)) ([4341802](https://github.com/nvim-neorocks/luarocks-tag-release/commit/4341802a7d2f7496e2e95e48cb14d5be0b079770))

## [5.2.42](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.41...v5.2.42) (2023-11-04)


### Dependencies

* update flake.lock ([#212](https://github.com/nvim-neorocks/luarocks-tag-release/issues/212)) ([6328db7](https://github.com/nvim-neorocks/luarocks-tag-release/commit/6328db773326a9a5307dacc58d9a6cab2e2c86b6))

## [5.2.41](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.40...v5.2.41) (2023-11-03)


### Dependencies

* update flake.lock ([#210](https://github.com/nvim-neorocks/luarocks-tag-release/issues/210)) ([b0d878b](https://github.com/nvim-neorocks/luarocks-tag-release/commit/b0d878b80d450c85fe5a1ebfc44344aad1363409))

## [5.2.40](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.39...v5.2.40) (2023-11-02)


### Dependencies

* update flake.lock ([#208](https://github.com/nvim-neorocks/luarocks-tag-release/issues/208)) ([82880fb](https://github.com/nvim-neorocks/luarocks-tag-release/commit/82880fbd6e36cbfd861563d887eec2b240c8bd93))

## [5.2.39](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.38...v5.2.39) (2023-10-30)


### Dependencies

* update flake.lock ([#206](https://github.com/nvim-neorocks/luarocks-tag-release/issues/206)) ([6cb3a44](https://github.com/nvim-neorocks/luarocks-tag-release/commit/6cb3a44a586e28918e94cb60a993aacec9ede944))

## [5.2.38](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.37...v5.2.38) (2023-10-28)


### Dependencies

* update flake.lock ([#204](https://github.com/nvim-neorocks/luarocks-tag-release/issues/204)) ([d0f6cd0](https://github.com/nvim-neorocks/luarocks-tag-release/commit/d0f6cd041aa240df53e9bb3a5ef6e91e2cc33824))

## [5.2.37](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.36...v5.2.37) (2023-10-27)


### Dependencies

* update flake.lock ([#202](https://github.com/nvim-neorocks/luarocks-tag-release/issues/202)) ([d7a4390](https://github.com/nvim-neorocks/luarocks-tag-release/commit/d7a4390be0270d8e1411ebd53852b742b08059bc))

## [5.2.36](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.35...v5.2.36) (2023-10-26)


### Dependencies

* update flake.lock ([#200](https://github.com/nvim-neorocks/luarocks-tag-release/issues/200)) ([7abd4e5](https://github.com/nvim-neorocks/luarocks-tag-release/commit/7abd4e5f3ea049da8af13924ffd4a90dcd425940))

## [5.2.35](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.34...v5.2.35) (2023-10-25)


### Dependencies

* update flake.lock ([#198](https://github.com/nvim-neorocks/luarocks-tag-release/issues/198)) ([d21ab7e](https://github.com/nvim-neorocks/luarocks-tag-release/commit/d21ab7e1632e71ae904194872605903f84ae00a6))

## [5.2.34](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.33...v5.2.34) (2023-10-24)


### Dependencies

* update flake.lock ([#196](https://github.com/nvim-neorocks/luarocks-tag-release/issues/196)) ([26069d4](https://github.com/nvim-neorocks/luarocks-tag-release/commit/26069d4fae9da89b4b892a66bd95892edb4f923e))

## [5.2.33](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.32...v5.2.33) (2023-10-23)


### Dependencies

* update flake.lock ([#194](https://github.com/nvim-neorocks/luarocks-tag-release/issues/194)) ([0875530](https://github.com/nvim-neorocks/luarocks-tag-release/commit/08755306aa3ae575fbf2710da0e927cbae7a0c7a))

## [5.2.32](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.31...v5.2.32) (2023-10-22)


### Dependencies

* update flake.lock ([#192](https://github.com/nvim-neorocks/luarocks-tag-release/issues/192)) ([314185c](https://github.com/nvim-neorocks/luarocks-tag-release/commit/314185c8942418f0a4053661d7f6b8309b8df37b))

## [5.2.31](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.30...v5.2.31) (2023-10-21)


### Dependencies

* update flake.lock ([#190](https://github.com/nvim-neorocks/luarocks-tag-release/issues/190)) ([5c3146b](https://github.com/nvim-neorocks/luarocks-tag-release/commit/5c3146b756544b617faf3057d76e789f63c880a6))

## [5.2.30](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.29...v5.2.30) (2023-10-20)


### Dependencies

* update flake.lock ([#188](https://github.com/nvim-neorocks/luarocks-tag-release/issues/188)) ([b79f988](https://github.com/nvim-neorocks/luarocks-tag-release/commit/b79f988888864205734886564c9f5ee2d74f801b))

## [5.2.29](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.28...v5.2.29) (2023-10-19)


### Dependencies

* update flake.lock ([#186](https://github.com/nvim-neorocks/luarocks-tag-release/issues/186)) ([854867e](https://github.com/nvim-neorocks/luarocks-tag-release/commit/854867ea638c79906c01673f5ad2cd9494502f9d))

## [5.2.28](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.27...v5.2.28) (2023-10-18)


### Dependencies

* update flake.lock ([#184](https://github.com/nvim-neorocks/luarocks-tag-release/issues/184)) ([79bdf05](https://github.com/nvim-neorocks/luarocks-tag-release/commit/79bdf05b371ce84aca6969cc4b3eb1af8fa7f86b))

## [5.2.27](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.26...v5.2.27) (2023-10-17)


### Dependencies

* update flake.lock ([#182](https://github.com/nvim-neorocks/luarocks-tag-release/issues/182)) ([b06a9af](https://github.com/nvim-neorocks/luarocks-tag-release/commit/b06a9af1eba098e78e3c4d4640d6fa0b47713e37))

## [5.2.26](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.25...v5.2.26) (2023-10-16)


### Dependencies

* update flake.lock ([#180](https://github.com/nvim-neorocks/luarocks-tag-release/issues/180)) ([acd53e7](https://github.com/nvim-neorocks/luarocks-tag-release/commit/acd53e70fc29c3b8da6872034d65c7f93bd57bf0))

## [5.2.25](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.24...v5.2.25) (2023-10-15)


### Dependencies

* update flake.lock ([#178](https://github.com/nvim-neorocks/luarocks-tag-release/issues/178)) ([664c003](https://github.com/nvim-neorocks/luarocks-tag-release/commit/664c0032c992db42253c44c4ec3b1ab467b1fa82))

## [5.2.24](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.23...v5.2.24) (2023-10-14)


### Dependencies

* update flake.lock ([#176](https://github.com/nvim-neorocks/luarocks-tag-release/issues/176)) ([7565503](https://github.com/nvim-neorocks/luarocks-tag-release/commit/7565503eccf3d7c3ba7c257b9797524749884054))

## [5.2.23](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.22...v5.2.23) (2023-10-13)


### Dependencies

* update flake.lock ([#174](https://github.com/nvim-neorocks/luarocks-tag-release/issues/174)) ([3bb2a35](https://github.com/nvim-neorocks/luarocks-tag-release/commit/3bb2a35f45cbb28d9e73e64ef4e24626be766b45))

## [5.2.22](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.21...v5.2.22) (2023-10-12)


### Dependencies

* update flake.lock ([#172](https://github.com/nvim-neorocks/luarocks-tag-release/issues/172)) ([4a101cc](https://github.com/nvim-neorocks/luarocks-tag-release/commit/4a101cc801436a130056fcd8407e37121080e1a1))

## [5.2.21](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.20...v5.2.21) (2023-10-11)


### Dependencies

* update flake.lock ([#170](https://github.com/nvim-neorocks/luarocks-tag-release/issues/170)) ([2caf3b0](https://github.com/nvim-neorocks/luarocks-tag-release/commit/2caf3b008aa278f1b4cd01161cfd88db884f16c8))

## [5.2.20](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.19...v5.2.20) (2023-10-10)


### Dependencies

* update flake.lock ([#168](https://github.com/nvim-neorocks/luarocks-tag-release/issues/168)) ([f76959d](https://github.com/nvim-neorocks/luarocks-tag-release/commit/f76959d263de73624c8127702ba922c56eb3bac8))

## [5.2.19](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.18...v5.2.19) (2023-10-09)


### Dependencies

* update flake.lock ([#166](https://github.com/nvim-neorocks/luarocks-tag-release/issues/166)) ([26578fc](https://github.com/nvim-neorocks/luarocks-tag-release/commit/26578fc958326c34107a61829a16580d70bf5df4))

## [5.2.18](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.17...v5.2.18) (2023-10-08)


### Dependencies

* update flake.lock ([#164](https://github.com/nvim-neorocks/luarocks-tag-release/issues/164)) ([0d30865](https://github.com/nvim-neorocks/luarocks-tag-release/commit/0d308655832ab958da4a1edaf88407c9b4190423))

## [5.2.17](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.16...v5.2.17) (2023-10-07)


### Dependencies

* update flake.lock ([#162](https://github.com/nvim-neorocks/luarocks-tag-release/issues/162)) ([05f180d](https://github.com/nvim-neorocks/luarocks-tag-release/commit/05f180d9d0f4423778d344d123c731c720e96151))

## [5.2.16](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.15...v5.2.16) (2023-10-06)


### Dependencies

* update flake.lock ([#160](https://github.com/nvim-neorocks/luarocks-tag-release/issues/160)) ([948669a](https://github.com/nvim-neorocks/luarocks-tag-release/commit/948669afe338736fe178628db90d2a050fa2140f))

## [5.2.15](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.14...v5.2.15) (2023-10-05)


### Dependencies

* update flake.lock ([#158](https://github.com/nvim-neorocks/luarocks-tag-release/issues/158)) ([af391f7](https://github.com/nvim-neorocks/luarocks-tag-release/commit/af391f74ddeebfc25b9b13a4e21e1c662444edeb))

## [5.2.14](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.13...v5.2.14) (2023-10-04)


### Dependencies

* update flake.lock ([#156](https://github.com/nvim-neorocks/luarocks-tag-release/issues/156)) ([912bef0](https://github.com/nvim-neorocks/luarocks-tag-release/commit/912bef03e92323f1950a2d131bd333041fdcee3e))

## [5.2.13](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.12...v5.2.13) (2023-10-03)


### Dependencies

* update flake.lock ([#154](https://github.com/nvim-neorocks/luarocks-tag-release/issues/154)) ([19a31c1](https://github.com/nvim-neorocks/luarocks-tag-release/commit/19a31c1a282a7857fd5df0249ae1cc853728c1b4))

## [5.2.12](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.11...v5.2.12) (2023-10-02)


### Dependencies

* update flake.lock ([#152](https://github.com/nvim-neorocks/luarocks-tag-release/issues/152)) ([d6a190d](https://github.com/nvim-neorocks/luarocks-tag-release/commit/d6a190dff6dc18293dd482e37880dee0de59d5cb))

## [5.2.11](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.10...v5.2.11) (2023-10-01)


### Dependencies

* update flake.lock ([#150](https://github.com/nvim-neorocks/luarocks-tag-release/issues/150)) ([9919764](https://github.com/nvim-neorocks/luarocks-tag-release/commit/99197644166c613b37af35f36fc936fa39c0d442))

## [5.2.10](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.9...v5.2.10) (2023-09-30)


### Dependencies

* update flake.lock ([#148](https://github.com/nvim-neorocks/luarocks-tag-release/issues/148)) ([d8ec9bf](https://github.com/nvim-neorocks/luarocks-tag-release/commit/d8ec9bfb0105d509c18c84d6562b2bc9f3954e91))

## [5.2.9](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.8...v5.2.9) (2023-09-29)


### Dependencies

* update flake.lock ([#146](https://github.com/nvim-neorocks/luarocks-tag-release/issues/146)) ([2207cd8](https://github.com/nvim-neorocks/luarocks-tag-release/commit/2207cd8eda78e422db1e8e59a753abd850d2164d))

## [5.2.8](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.7...v5.2.8) (2023-09-28)


### Dependencies

* update flake.lock ([#144](https://github.com/nvim-neorocks/luarocks-tag-release/issues/144)) ([3215e19](https://github.com/nvim-neorocks/luarocks-tag-release/commit/3215e1943c33be524e4b7d9c0f8cf7dcac8df953))

## [5.2.7](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.6...v5.2.7) (2023-09-27)


### Dependencies

* update flake.lock ([#142](https://github.com/nvim-neorocks/luarocks-tag-release/issues/142)) ([391adc5](https://github.com/nvim-neorocks/luarocks-tag-release/commit/391adc5ce61c45c2b6406cdc922eb6b8678455bd))

## [5.2.6](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.5...v5.2.6) (2023-09-26)


### Dependencies

* update flake.lock ([#140](https://github.com/nvim-neorocks/luarocks-tag-release/issues/140)) ([f84c920](https://github.com/nvim-neorocks/luarocks-tag-release/commit/f84c920e1386658d6c75f92ea91b06d633f39e0a))

## [5.2.5](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.4...v5.2.5) (2023-09-25)


### Dependencies

* update flake.lock ([#138](https://github.com/nvim-neorocks/luarocks-tag-release/issues/138)) ([34216ba](https://github.com/nvim-neorocks/luarocks-tag-release/commit/34216ba92846032c9b653021aca51de90b5b2af0))

## [5.2.4](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.3...v5.2.4) (2023-09-24)


### Dependencies

* update flake.lock ([#136](https://github.com/nvim-neorocks/luarocks-tag-release/issues/136)) ([da0d5e7](https://github.com/nvim-neorocks/luarocks-tag-release/commit/da0d5e772227f6bfc7d9fad3033baccdb99c75bd))

## [5.2.3](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.2...v5.2.3) (2023-09-23)


### Dependencies

* update flake.lock ([#134](https://github.com/nvim-neorocks/luarocks-tag-release/issues/134)) ([fec59f6](https://github.com/nvim-neorocks/luarocks-tag-release/commit/fec59f631a092c9448f8ee89ed26e08656b1f546))

## [5.2.2](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.1...v5.2.2) (2023-09-22)


### Dependencies

* update flake.lock ([#132](https://github.com/nvim-neorocks/luarocks-tag-release/issues/132)) ([6ca153c](https://github.com/nvim-neorocks/luarocks-tag-release/commit/6ca153c533551230fa6f7594ae0b35bd740e52ec))

## [5.2.1](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.2.0...v5.2.1) (2023-09-21)


### Dependencies

* update flake.lock ([#130](https://github.com/nvim-neorocks/luarocks-tag-release/issues/130)) ([5396e87](https://github.com/nvim-neorocks/luarocks-tag-release/commit/5396e87b635c9bf5537767442aaf87ce9f49e9e7))

## [5.2.0](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.1.15...v5.2.0) (2023-09-20)


### Features

* enable verbose logging if run with debug mode ([#128](https://github.com/nvim-neorocks/luarocks-tag-release/issues/128)) ([1d6da4a](https://github.com/nvim-neorocks/luarocks-tag-release/commit/1d6da4a603db28460dda4accaee28a7469fc8ea7))

## [5.1.15](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.1.14...v5.1.15) (2023-09-20)


### Dependencies

* update flake.lock ([#126](https://github.com/nvim-neorocks/luarocks-tag-release/issues/126)) ([dccb622](https://github.com/nvim-neorocks/luarocks-tag-release/commit/dccb622c9678ad2d3403b7dbe9b395c8ff374f28))

## [5.1.14](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.1.13...v5.1.14) (2023-09-19)


### Dependencies

* update flake.lock ([#124](https://github.com/nvim-neorocks/luarocks-tag-release/issues/124)) ([b998e7d](https://github.com/nvim-neorocks/luarocks-tag-release/commit/b998e7dc0dde63ec6277674d63351be6182c175a))

## [5.1.13](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.1.12...v5.1.13) (2023-09-18)


### Dependencies

* update flake.lock ([#122](https://github.com/nvim-neorocks/luarocks-tag-release/issues/122)) ([9d2c7a9](https://github.com/nvim-neorocks/luarocks-tag-release/commit/9d2c7a9d0949e9104d0826cdf782a55277d747ec))

## [5.1.12](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.1.11...v5.1.12) (2023-09-17)


### Dependencies

* update flake.lock ([#120](https://github.com/nvim-neorocks/luarocks-tag-release/issues/120)) ([381cff5](https://github.com/nvim-neorocks/luarocks-tag-release/commit/381cff54f3e65c7945081c8efe24692b38e40be2))

## [5.1.11](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.1.10...v5.1.11) (2023-09-16)


### Dependencies

* update flake.lock ([#117](https://github.com/nvim-neorocks/luarocks-tag-release/issues/117)) ([ccbd7c4](https://github.com/nvim-neorocks/luarocks-tag-release/commit/ccbd7c4deb0348cf534fb466183d8c7f984bcda4))

## [5.1.10](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.1.9...v5.1.10) (2023-09-15)


### Bug Fixes

* print `luarocks test` `stdout` and `stderr` to workflow log ([#115](https://github.com/nvim-neorocks/luarocks-tag-release/issues/115)) ([471de81](https://github.com/nvim-neorocks/luarocks-tag-release/commit/471de8105506a579549ba6906c03f7d784dc2d2c))

## [5.1.9](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.1.8...v5.1.9) (2023-09-15)


### Dependencies

* update flake.lock ([#111](https://github.com/nvim-neorocks/luarocks-tag-release/issues/111)) ([9729c40](https://github.com/nvim-neorocks/luarocks-tag-release/commit/9729c40fefe62bfa4db7aec5402c350166ea53d4))

## [5.1.8](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.1.7...v5.1.8) (2023-09-14)


### Dependencies

* update flake.lock ([#109](https://github.com/nvim-neorocks/luarocks-tag-release/issues/109)) ([625efc9](https://github.com/nvim-neorocks/luarocks-tag-release/commit/625efc984574c16ca973b9a2ed5d09bdbae8e880))

## [5.1.7](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.1.6...v5.1.7) (2023-09-13)


### Dependencies

* update flake.lock ([#107](https://github.com/nvim-neorocks/luarocks-tag-release/issues/107)) ([11f3a86](https://github.com/nvim-neorocks/luarocks-tag-release/commit/11f3a8648eb5b4ed5c0e33523eea409ef4b69165))

## [5.1.6](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.1.5...v5.1.6) (2023-09-12)


### Bug Fixes

* auto-tag releases ([a3b23d3](https://github.com/nvim-neorocks/luarocks-tag-release/commit/a3b23d3bfae9bc2eb10efe789da2294f17027e06))
* **dependencies:** update flake.lock ([#105](https://github.com/nvim-neorocks/luarocks-tag-release/issues/105)) ([a29081d](https://github.com/nvim-neorocks/luarocks-tag-release/commit/a29081d5e1a7fda19feee925be53b7556b366e04))


### Reverts

* add workflow_dispatch to actions-tagger ([38705c8](https://github.com/nvim-neorocks/luarocks-tag-release/commit/38705c88e9b177dba09cd0fc8ef4b15e1b9b749d))

## [5.1.5](https://github.com/nvim-neorocks/luarocks-tag-release/compare/v5.1.4...v5.1.5) (2023-09-11)


### Bug Fixes

* **dependencies:** update flake.lock ([#98](https://github.com/nvim-neorocks/luarocks-tag-release/issues/98)) ([c3119ad](https://github.com/nvim-neorocks/luarocks-tag-release/commit/c3119adf5d1b990ee9aa6d177bcac4518d529784))
* **dependencies:** update flake.lock ([#99](https://github.com/nvim-neorocks/luarocks-tag-release/issues/99)) ([0672f79](https://github.com/nvim-neorocks/luarocks-tag-release/commit/0672f7915dd98c32c3020e067a133387409d5abd))

## [v5.1.4] - 2023-08-06
### Fixed
- Broken `{{ neovim.plugin.dirs }}` variable detection.

## [v5.1.3] - 2023-07-28
### Fixed
- Include stdout + stderr in error messages.

## [v5.1.2] - 2023-07-28
### Fixed
- Avoid duplicate `lua` dependencies in rockspec
  if specified in dependencies input.
### Changed
- Print generated rockspec's filename in workflow log.

## [v5.1.1] - 2023-07-17
### Fixed
- Use `GITHUB_EVENT_PATH` to get extra repo info
  (instead of GitHub REST API, which is flaky).

## [v5.1.0] - 2023-07-13
### Added
- Ability to test a local `luarocks install`, without uploading to luarocks.org
  on `pull_request`.

## [v5.0.1] - 2023-07-06
### Fixed
- Run `luarocks test` only if a `.busted` file exists in the project root.

## [v5.0.0] - 2023-06-04
### Added
- Ability to run `luarocks test` with Neovim as an interpreter.
  POTENIALLY BREAKING: Packages that have [busted](https://lunarmodules.github.io/busted/#usage)
  tests will fail to release if the test suite fails.

## [v4.0.1] - 2023-03-29
### Changed
- Change license to AGPLv3.0.
  Note: This does not affect the permission to use this action with a package that has a different license.
### Fixed
- Add `ftplugin` to `{{ neovim.plugin.dirs }}`.

## [v4.0.0] - 2023-03-19
- POTENIALLY BREAKING: Convert to composite action.
- POTENTIALLY BREAKING: Remove redundant `build_type` input.
  Use `template` input for non-builtin build types instead.
- Remove `gnumake` from shell wrapper (no longer needed in a composite action).

## [v3.0.0] - 2023-03-08
### Added
- Add directories from Neovim's `runtimepath` and some common plugin directories
  as the default for the `copy_directories` input.
  BREAKING CHANGE: This could potentially add new directories to LuaRocks packages,
  if the `copy_directories` input is not explicity specified, and one of the new default directories exists.
### Changed
- Only add directories that exist to the rockspec's `copy_directories`.

## [v2.3.0] - 2023-03-01
### Added
- Maintain `vX` and `vX.X` tags for the latest non-breaking releases.
### Fixed
- Only install packages locally when running as non-root.
  Fixes build failure in docker container.
### Changed
- Remove ShellCheck and transitive GHC dependency.

## [v2.2.0] - 2023-02-24
### Added
- Added 'make' to build environment to fix the support for rockspecs of build type 'make'.

## [v2.1.0] - 2023-02-17
### Added
- Optional `version` input to support basic git workflows (#11).

## [v2.0.0] - 2023-02-10
### Added
- Optional `license` input.
### Changed
- BREAKING: The action will fail if no `license` input is set and GitHub cannot determine the license automatically.

## [v1.0.2] - 2023-02-06
### Fixed
- Escape quotes in summary

## [v1.0.1] - 2023-02-03
### Fixed
- Used wrong entrypoint.sh

## [v1.0.0] - 2023-02-03
### Added
- First release.
