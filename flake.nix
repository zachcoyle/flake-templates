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
    };
  };
}
