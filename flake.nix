{
  description = "flake templates";

  outputs = { self }: {
    templates = {
      poetry2nix = {
        path = ./poetry2nix;
        description = "poetry2nix flake template";
      };
      naersk = {
        path = ./naersk;
        description = "naersk flake template";
      };
      yarn2nix = {
        path = ./yarn2nix;
        description = "yarn2nix flake template";
      };
      mobile_dev = {
        path = ./mobile_dev;
        description = "mobile development flake template";
      };
      flake-utils = {
        path = ./flake-utils;
        description = "flake-utils template";
      };
      latex = {
        path = ./latex;
        description = "latex template";
      };
      mach-nix = {
        path = ./mach-nix;
        description = "mach-nix template";
      };
    };
  };
}
