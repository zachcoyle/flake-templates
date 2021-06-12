{
  description = "latex document";

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

        # packages.my-document = pkgs.stdenv.mkDerivation {
        #   name = "my-document";
        #   buildInputs = with pkgs; [
        #     texlive.combined.scheme-full
        #     pkgs.nerdfonts
        #   ];
        #   src = ./.;
        #   buildPhase = ''
        #     pdflatex my-document.tex
        #   '';
        #   installPhase = ''
        #     mkdir -p $out
        #     cp my-document.pdf $out
        #   '';
        # };
        #
        # defaultPackage = packages.my-document;

        devShell = pkgs.devshell.mkShell {
          packages = with pkgs; [
            texlive.combined.scheme-full
          ];
        };
      });
}
