{
  inputs = {
    nixpkgs.url = "github:cachix/devenv-nixpkgs/rolling";
    systems.url = "github:nix-systems/default";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    sqlcquash.url = "github:conneroisu/sqlcquash/main";
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.follows = "dream2nix/nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    flake-utils,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (system: let
      unstable-pkgs = import nixpkgs-unstable {
        inherit system;
        overlays = [];
      };
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
        ];
        config = {
          allowUnfree = true;
        };
      };
    in {
      #
      packages = {
      };
      #
      containers = {
      };
    });
}
