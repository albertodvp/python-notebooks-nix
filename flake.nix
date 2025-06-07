{
  description = "A Nix Flake Template";

  outputs = { self, ... }: {
    templates = {
      base = {
        path = ./templates/base;
        description = "A simple flake to use jupyter";
      };
      default = self.templates.base;
    };
  };
}
