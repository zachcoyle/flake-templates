{
  description = "naersk flake template";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    flake-utils.url = github:numtide/flake-utils;
    naersk.url = "github:nmattia/naersk";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, fenix, naersk }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ fenix.overlay ];
        };
        naersk-lib = naersk.lib.${system}.override {
          inherit (fenix.packages.${system}.minimal) cargo rustc;
        };
      in
      {
        # packages.my-project = naersk-lib.buildPackage {
        #   pname = "my-project";
        #   root = ./.;
        # };

        # defaultPackage = packages.my-project;

        # apps.my-project = utils.lib.mkApp {
        #   drv = packages.my-project;
        # };

        # defaultApp = apps.my-project;

        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            fenix.packages.${system}.minimal.cargo
            fenix.packages.${system}.minimal.rustc
          ];
        };

      });
}
