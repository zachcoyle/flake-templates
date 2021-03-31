{
  description = "yarn2nix flake template";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    flake-utils.url = github:numtide/flake-utils;
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        # packages.my-project = (pkgs.yarn2nix-moretea.override (_: {
        #   yarn = pkgs.yarn;
        #   nodejs = nodejs-15_x;
        # })).mkYarnPackage {
        #   name = "my-project";
        #   src = ./.;
        #   packageJSON = ./package.json;
        #   yarnLock = ./yarn.lock;
        #   publishBinsFor = [ ];
        # };

        # defaultPackage = packages.my-project;

        # apps.my-project = utils.lib.mkApp {
        #   drv = packages.my-project;
        # };

        # defaultApp = apps.my-project;

        devShell = mkShell {
          buildInputs = with pkgs; [
            yarn
            nodejs-15_x
          ];
        };
      });
}
