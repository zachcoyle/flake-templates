{
  description = "";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    flake-utils.url = github:numtide/flake-utils;
    devshell.url = github:numtide/devshell;
  };

  outputs = { self, nixpkgs, flake-utils, devshell }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ devshell.overlay ];
      };

      # my-package = pkgs.haskellPackages.callPackage ./default.nix { };

    in
    rec {

      # packages.my-package = pkgs.my-package;

      # defaultPackage = packages.my-package;

      devShell = pkgs.devshell.mkShell {
        packages = with pkgs; [
          cabal2nix
          ghc
          haskellPackages.cabal-install
          stack
        ];
      };

    });
}
