{
  description = "yarn2nix flake template";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    flake-utils.url = github:numtide/flake-utils;
    devshell.url = github:numtide/devshell;
  };

  outputs = { self, nixpkgs, flake-utils, devshell }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ devshell.overlay ];
        };
      in
      rec {
        # packages.my-project = (pkgs.yarn2nix-moretea.override (_: {
        #   yarn = pkgs.yarn;
        #   nodejs = pkgs.nodejs-16_x;
        # })).mkYarnPackage {
        #   name = "my-project";
        #   src = ./.;
        #   packageJSON = ./package.json;
        #   yarnLock = ./yarn.lock;
        #   publishBinsFor = [ ];
        # };

        # defaultPackage = packages.my-project;

        # apps.my-project = flake-utils.lib.mkApp {
        #   drv = packages.my-project;
        # };

        # defaultApp = apps.my-project;

        devShell = pkgs.devshell.mkShell {
          packages = with pkgs; [
            yarn
            nodejs-16_x
          ];
        };
      });
}
