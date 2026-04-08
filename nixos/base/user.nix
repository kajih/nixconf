{self, ...}: {
  flake.nixosModules.base = {lib, ...}: {
    imports = [
      self.nixosModules.extra_hjem
    ];

    options.preferences = {
      user.name = lib.mkOption {
        type = lib.types.str;
        default = "kajih";
      };
    };
  };
}
