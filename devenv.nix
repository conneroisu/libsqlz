{
  pkgs,
  lib,
  # config,
  inputs,
  ...
}: let
  unstable-pkgs = import inputs.nixpkgs-unstable {
    inherit (pkgs) system;
    overlays = [];
  };
in {
  name = "pegwings";
  languages = {
    zig = {
      enable = true;
      package = unstable-pkgs.zig;
    };
    nix.enable = true;
    rust.enable = true;
    c.enable = true;
  };

  git-hooks = {
    hooks = {
      alejandra.enable = true;
      zigfmt = {
        enable = true;
        name = "zigfmt";
        entry = "${unstable-pkgs.zig}/bin/zig fmt";
        files = "\\.(zig)$";
        types = ["zig"];
        language = "system";
      };
    };
  };

  enterShell =
    ''
      git status
      git log HEAD..origin/main --oneline
      export REPO_ROOT=$(git rev-parse --show-toplevel)
    ''
    + lib.optionalString pkgs.stdenv.isLinux ''
    ''
    + lib.optionalString pkgs.stdenv.isDarwin ''
    '';

  enterTest = ''
    echo "Running tests"
    nix flake check --no-pure-eval --all-systems
  '';

  cachix.enable = true;

  # https://devenv.sh/packages/
  packages =
    (with unstable-pkgs; [
      zls
      cargo-zigbuild
    ])
    ++ (with pkgs; [
      alejandra
      sqldiff
    ])
    ++ (
      if pkgs.stdenv.isDarwin
      then
        (with pkgs.darwin.apple_sdk; [
          frameworks.SystemConfiguration
        ])
      else []
    );

  scripts = {
    build.exec = ''
      zig build
    '';
    tests.exec = ''
      rm -rf $REPO_ROOT/.zig-cache/
      unset UNIT
      zig build test
    '';
    unit-tests.exec = ''
      rm -rf $REPO_ROOT/.zig-cache/
      export UNIT=true
      zig build test
      unset UNIT
    '';
    dx.exec = ''
      $EDITOR $REPO_ROOT/devenv.nix
    '';
  };
}
