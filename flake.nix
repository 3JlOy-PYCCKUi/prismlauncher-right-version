{
  description = "prismlauncher-right-version for nix and nixos";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs @{ self, flake-utils, nixpkgs, ... }:
    let
      overlays = [
        # Other overlays
      ];
    in
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system overlays; };
        prismlauncher-right-version-unwrapped = pkgs.prismlauncher-unwrapped.overrideAttrs (old: {
          patches = old.patches or [ ] ++
            [
              ./0001.patch
            ];
        });
      in
      rec {
        packages.default = pkgs.prismlauncher.override {
          prismlauncher-unwrapped = prismlauncher-right-version-unwrapped;
        };
        defaultPackage = packages.prismlauncher-right-version;
        overlays = [
          (_: _: {
            prismlauncher-right-version = packages.default;
          })
        ];
      });
}

