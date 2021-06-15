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
    in
    rec {

      packages.hello = pkgs.hello;

      defaultPackage = packages.hello;

      devShell = pkgs.devshell.mkShell {
        packages = with pkgs; [ ];
      };

    });
}
