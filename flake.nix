{
  description = "Build and upload LuaRocks packages from Git tags";

  nixConfig = {
    extra-substituters = "https://neorocks.cachix.org";
    extra-trusted-public-keys = "neorocks.cachix.org-1:WqMESxmVTOJX7qoBC54TwrMMoVI1xAM+7yFin8NRfwk=";
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    git-hooks,
    ...
  }: let
    supportedSystems = [
      "x86_64-linux"
    ];
  in
    flake-utils.lib.eachSystem supportedSystems (system: let
      pkgs = import nixpkgs {inherit system;};

      formatting = git-hooks.lib.${system}.run {
        src = self;
        hooks = {
          alejandra.enable = true;
          stylua.enable = true;
          luacheck.enable = true;
          editorconfig-checker.enable = true;
          markdownlint = {
            enable = true;
            settings.configuration = {
              MD004 = false;
              MD012 = false;
              MD013 = false;
              MD022 = false;
              MD031 = false;
              MD032 = false;
            };
          };
        };
      };

      shell = pkgs.mkShell {
        name = "luarocks-tag-release-devShell";
        buildInputs =
          (with pkgs; [
            lua-language-server
            lux-cli
            luarocks
            lua55Packages.dkjson
            lua5_5
          ])
          ++ self.checks.${system}.formatting.enabledPackages;
        shellHook = ''
          ${self.checks.${system}.formatting.shellHook}
          export LUA_PATH="lua/?.lua;$LUA_PATH"
        '';
      };
    in {
      devShells.default = shell;
      checks = {
        inherit formatting;
      };
    });
}
