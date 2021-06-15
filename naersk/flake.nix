{
  description = "naersk flake template";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    flake-utils.url = github:numtide/flake-utils;
    devshell.url = github:numtide/devshell;
    naersk.url = "github:nmattia/naersk";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, fenix, naersk, devshell }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            devshell.overlay
            fenix.overlay
          ];
        };
        naersk-lib = naersk.lib.${system}.override {
          inherit (fenix.packages.${system}.minimal) cargo rustc;
        };
      in
      rec {
        # packages.my-project = naersk-lib.buildPackage {
        #   pname = "my-project";
        #   root = ./.;
        # };

        # defaultPackage = packages.my-project;

        # apps.my-project = flake-utils.lib.mkApp {
        #   drv = packages.my-project;
        # };

        # defaultApp = apps.my-project;

        devShell = pkgs.devshell.mkShell {
          buildInputs = with pkgs; [
            fenix.packages.${system}.minimal.cargo
            fenix.packages.${system}.minimal.rustc
          ];
        };

      });
}
