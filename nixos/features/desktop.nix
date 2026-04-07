{self, ...}: {
  flake.nixosModules.desktop = {pkgs, ...}: let
    selfpkgs = self.packages."${pkgs.stdenv.hostPlatform.system}";
  in {
    imports = [
      self.nixosModules.gtk

      self.nixosModules.pipewire
      self.nixosModules.firefox
      self.nixosModules.chromium
    ];

    # programs.niri.enable = true;
    # programs.niri.package = selfpkgs.niri;

    # preferences.autostart = [selfpkgs.quickshellWrapped];
    preferences.autostart = [selfpkgs.noctalia-shell];

    environment.systemPackages = [
      selfpkgs.terminal
      pkgs.pcmanfm
      selfpkgs.noctalia-shell
    ];

    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      ubuntu-sans
      cm_unicode
      corefonts
      unifont
    ];

    fonts.fontconfig.defaultFonts = {
      serif = ["Ubuntu Sans"];
      sansSerif = ["Ubuntu Sans"];
      monospace = ["JetBrainsMono Nerd Font"];
    };

    time.timeZone = "Europe/Stockholm";
    i18n.defaultLocale = "en_GB.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "sv_SE.UTF-8";
      LC_IDENTIFICATION = "sv_SE.UTF-8";
      LC_MEASUREMENT = "sv_SE.UTF-8";
      LC_MONETARY = "sv_SE.UTF-8";
      LC_NAME = "sv_SE.UTF-8";
      LC_NUMERIC = "sv_SE.UTF-8";
      LC_PAPER = "sv_SE.UTF-8";
      LC_TELEPHONE = "sv_SE.UTF-8";
      LC_TIME = "sv_SE.UTF-8";
    };

    console.keyMap = "sv-latin1";

    services.upower.enable = true;

    security.polkit.enable = true;

    hardware = {
      enableAllFirmware = true;

      bluetooth.enable = true;
      bluetooth.powerOnBoot = true;

      graphics.enable = true;
      graphics.enable32Bit = true;

    };
  };
}
