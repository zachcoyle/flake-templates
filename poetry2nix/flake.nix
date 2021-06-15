{
  description = "poetry2nix flake template";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    flake-utils.url = github:numtide/flake-utils;
    devshell.url = github:numtide/devshell;
    poetry2nix = {
      url = github:nix-community/poetry2nix;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, poetry2nix, devshell }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            devshell.overlay
            poetry2nix.overlay
          ];
        };
      in
      {
        # packages.my-project = poetry2nix.mkPoetryApplication {
        #   projectDir = ./.;
        # };

        # defaultPackage = packages.my-project;

        # apps.my-project = utils.lib.mkApp {
        #   drv = packages.my-project;
        # };

        # defaultApp = apps.my-project;

        devShell = pkgs.devshell.mkShell {
          buildInputs = with pkgs; [
            poetry
            (pkgs.poetry2nix.mkPoetryEnv { projectDir = ./.; })
          ];

          shellHook = ''
            poetry run true
          '';
        };

      });
}
