{
  description = "Libsql for Zig";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";
    flake-utils.inputs.systems.follows = "systems";

    systems.url = "github:nix-systems/default";

    zig = {
      url = "github:mitchellh/zig-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
    zls-overlay.url = "github:zigtools/zls";
  };

  nixConfig = {
    extra-substituters = ''
      https://cache.nixos.org
      https://nix-community.cachix.org
      https://devenv.cachix.org
    '';
    extra-trusted-public-keys = ''
      cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=
      nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=
      devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=
    '';
    extra-experimental-features = "nix-command flakes";
  };

  outputs = inputs @ {flake-utils, ...}:
    flake-utils.lib.eachSystem [
      "x86_64-linux"
      "i686-linux"
      "x86_64-darwin"
      "aarch64-linux"
      "aarch64-darwin"
    ] (system: let
      #
      zigpkgs = inputs.zig.packages.${system};
      overlays = [
        (final: prev: {
          inherit zigpkgs;
        })
      ];
      zig = zigpkgs.master;
      zls = inputs.zls-overlay.packages.x86_64-linux.zls.overrideAttrs (old: {
        nativeBuildInputs = [zig];
      });
      #
      pkgs = import inputs.nixpkgs {inherit system overlays;};
      #
      script = pkgs.writeShellScriptBin;
    in {
      packages = {
        doc = pkgs.stdenv.mkDerivation {
          pname = "libsqlz-zig-docs";
          version = "0.1";
          src = ./.;
          nativeBuildInputs = with pkgs; [
            nixdoc
            mdbook
            mdbook-open-on-gh
            mdbook-cmdrun
            git
          ];
          dontConfigure = true;
          dontFixup = true;
          env.RUST_BACKTRACE = 1;
          buildPhase = ''
            runHook preBuild
            cd doc
            mkdir -p .git
            mdbook build
            runHook postBuild
          '';
          installPhase = ''
            runHook preInstall
            mv book $out
            runHook postInstall
          '';
        };
      };

      devShells.default = pkgs.mkShell {
        shellHook = ''
          export REPO_ROOT=$(git rev-parse --show-toplevel)
        '';
        packages = with pkgs; [
          alejandra
          nixd
          zig
          zls

          (script "dx" ''
            $EDITOR $REPO_ROOT/flake.nix
          '')
          (script "build" ''
            nix build .#packages.x86_64-linux.conneroh
          '')
          (script "generate-all" ''
            go generate $REPO_ROOT/...
          '')
          (script "format" ''
            export REPO_ROOT=$(git rev-parse --show-toplevel) # needed

            git ls-files \
              --others \
              --exclude-standard \
              --cached \
              -- '*.js' '*.ts' '*.css' '*.md' '*.json' \
              | xargs prettier --write
          '')
        ];
      };
    });
}
