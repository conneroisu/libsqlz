{
  inputs = {
    nixpkgs.url = "github:cachix/devenv-nixpkgs/rolling";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    systems.url = "github:nix-systems/default";

    devenv = {
      url = "github:cachix/devenv";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    devenv,
    systems,
    ...
  } @ inputs: let
    forEachSystem = nixpkgs.lib.genAttrs (import systems);
  in {
    packages = forEachSystem (system: {
      devenv-up = self.devShells.${system}.default.config.procfileScript;
      devenv-test = self.devShells.${system}.default.config.test;
    });

    devShells =
      forEachSystem
      (system: let
        inherit (pkgs.stdenv) isLinux isDarwin isAarch64;
        pkgs = import nixpkgs {
          inherit system;
          overlays = [];
          config.allowUnfree = true;
        };
        pkgs-unstable = import nixpkgs-unstable {
          inherit system;
          overlays = [];
          config.allowUnfree = true;
        };
        rosettaPkgs =
          if isDarwin && isAarch64
          then pkgs.pkgsx86_64Darwin
          else pkgs;
      in {
        default = devenv.lib.mkShell {
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
                  package = pkgs-unstable.zig;
                };
                nix.enable = true;
                c.enable = true;
                rust.enable = true;
              };

              packages =
                (with pkgs-unstable; [
                  tcl
                  gnum4

                  watchexec
                  stdenv.cc

                  tbb # Intel Threading Building Blocks
                  llvmPackages.openmp # OpenMP support
                  binutils
                ])
                ++ (with pkgs; [
                  alejandra
                  libclang
                ])
                ++ pkgs.lib.optionals isLinux [
                  pkgs.xorg.libX11
                  pkgs.gdb
                ]
                ++ pkgs.lib.optionals isDarwin ((
                    with pkgs; [
                      darwin.apple_sdk.frameworks.CoreFoundation
                      darwin.apple_sdk.frameworks.Security
                      darwin.apple_sdk.frameworks.SystemConfiguration
                      rosettaPkgs.gdb
                    ]
                  )
                  ++ (
                    with pkgs-unstable; [
                      darwin.apple_sdk.frameworks.Foundation
                      darwin.apple_sdk.frameworks.IOKit
                    ]
                  ));

              enterShell = ''

                export REPO_ROOT=$(git rev-parse --show-toplevel)
                export LD_LIBRARY_PATH=${
                  pkgs.lib.makeLibraryPath (
                    (with pkgs-unstable; [
                      pkgs.mesa
                      stdenv.cc
                    ])
                    ++ (with pkgs; [
                      ])
                    ++ (
                      pkgs.lib.optionals isLinux [
                        pkgs.xorg.libX11
                      ]
                    )
                    ++ (
                      pkgs.lib.optionals isDarwin [
                        pkgs.darwin.apple_sdk.frameworks.CoreFoundation
                        pkgs.darwin.apple_sdk.frameworks.Security
                        pkgs.darwin.apple_sdk.frameworks.SystemConfiguration
                        pkgs.darwin.apple_sdk.frameworks.Foundation
                        pkgs.darwin.apple_sdk.frameworks.IOKit
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
                  # TODO: copy build outputs
                '';
              };

              cachix.enable = true;
            }
          ];
        };
      });
  };
}
