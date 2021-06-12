{
  description = "";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    flake-utils.url = github:numtide/flake-utils;
    devshell.url = github:numtide/devshell;
    mach-nix.url = github:DavHau/mach-nix;
  };

  outputs = { self, nixpkgs, flake-utils, devshell, mach-nix }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ devshell.overlay ];
      };

      # my-package = (import mach-nix { inherit pkgs; }).buildPythonApplication {
      #   src = ./.;
      # };

    in
    rec {

      # packages.my-package = my-package; 

      # defaultPackage = packages.my-package;

      devShell = pkgs.devshell.mkShell {
        packages = [ ];
      };

    });
}
