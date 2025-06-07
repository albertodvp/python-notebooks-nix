{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";
    git-hooks-nix.url = "github:cachix/git-hooks.nix";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.git-hooks-nix.flakeModule
      ];
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];
      perSystem =
        { config, pkgs, ... }:
        {
          devShells.default =
            pkgs.mkShell {
              nativeBuildInputs = with pkgs; [
                config.pre-commit.settings.enabledPackages
                (python3.withPackages (
                  ps: with ps; [
                    ipython
                    jupyter
                    numpy
                    polars
                    requests
                  ]
                ))
              ];
              shellHook = ''
                ${config.pre-commit.installationScript}
              '';
            };
          pre-commit = {
            settings = {
              default_stages = [
                "pre-commit"
                "pre-push"
              ];
              hooks = {
                typos.enable = true;
                markdownlint.enable = true;
                ruff.enable = true;
                mypy.enable = true;
              };
            };
          };
        };
    };
}
