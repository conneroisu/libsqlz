{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    systems.url = "github:nix-systems/default";
    flake-utils.url = "github:numtide/flake-utils";
    flake-utils.inputs.systems.follows = "systems";

    devenv = {
      url = "github:cachix/devenv";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    extra-substituters = "https://cache.nixos.org https://nix-community.cachix.org https://devenv.cachix.org";
    extra-trusted-public-keys = "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs= sylvorg.cachix.org-1:xd1jb7cDkzX+D+Wqt6TemzkJH9u9esXEFu1yaR9p8H8= devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-experimental-features = "nix-command flakes";
  };

  outputs = {
    self,
    nixpkgs,
    devenv,
    flake-utils,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (system: let
      inherit (pkgs.stdenv) isLinux isDarwin isAarch64;
      pkgs = import nixpkgs {
        inherit system;
        overlays = [];
        config.allowUnfree = true;
      };
      rosettaPkgs =
        if isDarwin && isAarch64
        then pkgs.pkgsx86_64Darwin
        else pkgs;
    in {
      packages = {
        devenv-up = self.devShells.${system}.default.config.procfileScript;
        devenv-test = self.devShells.${system}.default.config.test;
      };

      devShells.default = devenv.lib.mkShell {
        inherit inputs pkgs;
        modules = [
          {
            #
            devcontainer = {
              enable = true;
              settings.customizations.vscode.extensions = [
                "github.copilot"
                "github.codespaces"
                "ms-python.vscode-pylance"
                "redhat.vscode-yaml"
                "redhat.vscode-xml"
                "visualstudioexptteam.vscodeintellicode"
                "bradlc.vscode-tailwindcss"
                "christian-kohler.path-intellisense"
                "supermaven.supermaven"
                "jnoortheen.nix-ide"
                "mkhl.direnv"
                "tamasfe.even-better-toml"
                "eamodio.gitlens"
                "streetsidesoftware.code-spell-checker"
                "editorconfig.editorconfig"
              ];
            };

            git-hooks = {
              hooks = {
                alejandra.enable = true;
              };
            };

            languages = {
              zig = {
                enable = true;
                package = pkgs.zig;
              };
              rust.enable = true;
              nix.enable = true;
              c.enable = true;
            };

            packages =
              (with pkgs; [
                tcl
                watchexec
                binutils
                antlr4
              ])
              ++ (with pkgs; [
                alejandra
                libclang
              ])
              ++ pkgs.lib.optionals isLinux [
                pkgs.xorg.libX11
                pkgs.gdb
              ]
              ++ pkgs.lib.optionals isDarwin [
                rosettaPkgs.gdb
              ]
              ++ (
                with pkgs; [
                  darwin.apple_sdk.frameworks.Foundation
                  darwin.apple_sdk.frameworks.IOKit
                ]
              );

            enterShell = ''

              export REPO_ROOT=$(git rev-parse --show-toplevel)
              export LD_LIBRARY_PATH=${
                pkgs.lib.makeLibraryPath (
                  (with pkgs; [
                    pkgs.mesa
                    stdenv.cc
                  ])
                  ++ (
                    pkgs.lib.optionals isLinux [
                      pkgs.xorg.libX11
                    ]
                  )
                  ++ (
                    pkgs.lib.optionals isDarwin [
                    ]
                  )
                )
              }:$LD_LIBRARY_PATH

            '';

            scripts = {
              dx.exec = ''
                $EDITOR $REPO_ROOT/flake.nix
              '';

              build-libsqlc.exec = ''
                cd ./vendor/libsql-c
                sh build.sh
                # TODO: auto copy build outputs
              '';

              tests.exec = ''
                rm -rf ./.zig-cache/
                zig build test --summary all
              '';
            };

            cachix.enable = true;
          }
        ];
      };
    });
}
