{self, inputs, lib, ...}: {
  perSystem = {
    pkgs,
    self',
    ...
  }: {
    # Desktop wrapper
    packages.desktop =
      (inputs.wrappers.wrapperModules.niri.apply ({config, ...}: {
        inherit pkgs;
        imports = [self.wrappersModules.niri];
        terminal = lib.getExe self'.packages.terminal;
        env = {
          EDITOR = lib.getExe self'.packages.neovimDynamic;
        };
      })).wrapper;

    # Terminal wrapper
    packages.terminal =
      (inputs.wrappers.wrapperModules.kitty.apply {
        inherit pkgs;
        imports = [self.wrappersModules.kitty];
      }).wrapper;

    packages.nix-check-bin = pkgs.writeShellApplication {
      name = "nix-check-bin";
      text = ''
        $EDITOR "$(nix build "$1" --no-link --print-out-paths)/bin"
      '';
    };
  };

  flake.nixosModules.general = {
    pkgs,
    config,
    lib,
    ...
  }: let
    sysPkgs = self.packages.${pkgs.stdenv.hostPlatform.system};
  in {
    imports = [
      self.nixosModules.gtk
      self.nixosModules.nix
    ];

    users.users.${config.preferences.user.name} = {
      isNormalUser = true;
      description = "${config.preferences.user.name}'s account";
      extraGroups = ["wheel" "networkmanager"];
      shell = pkgs.fish;

      hashedPasswordFile = "/persist/passwd";
      # initialPassword = "12345";
    };

    programs.fish.enable = true;



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
