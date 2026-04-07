{self, ...}: {
  flake.nixosModules.general = {
    pkgs,
    config,
    lib,
    ...
  }: let
    neovim = self.packages.${pkgs.stdenv.hostPlatform.system}.neovim;
  in {
    imports = [
      self.nixosModules.extra_hjem
      self.nixosModules.gtk
      self.nixosModules.nix
    ];

    users.users.${config.preferences.user.name} = {
      isNormalUser = true;
      description = "${config.preferences.user.name}'s account";
      extraGroups = ["wheel" "networkmanager"];
      shell = self.packages.${pkgs.stdenv.hostPlatform.system}.environment;

      hashedPasswordFile = "/persist/passwd";
      # initialPassword = "12345";
    };

    environment.systemPackages = [ neovim ];
    environment.variables.EDITOR = lib.getExe neovim;
    environment.shellAliases = {
      vi  = "nvim";
      vim = "nvim";
    };

    persistance.data.directories = [
      ".ssh"
      "nixconf"
      "src"
      "Videos"
      "Documents"
      "Projects"
    ];

    # todo: remove
    persistance.cache.directories = [
      ".local/share/zoxide"
      ".local/share/direnv"
      ".local/share/nvim"
      ".local/share/fish"
      ".config/nvim"
    ];
  };
}
