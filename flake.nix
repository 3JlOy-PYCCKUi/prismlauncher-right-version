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
      in
      rec {
        packages.default = pkgs.prismlauncher.overrideAttrs (old: {
            patches =
              old.patches or [ ] ++
              [
                ./0001.patch
              ];
          });
        defaultPackage = packages.prismlauncher-right-version;
      });
}

