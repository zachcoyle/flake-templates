{
  description = "poetry2nix flake template";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    flake-utils.url = github:numtide/flake-utils;
    poetry2nix = {
      url = github:nix-community/poetry2nix;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, poetry2nix }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ poetry2nix.overlay ];
        };
      in
      {
        packages = { };

        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            poetry
            (pkgs.poetry2nix.mkPoetryEnv { projectDir = ./.; })
          ];
        };

      });
}
