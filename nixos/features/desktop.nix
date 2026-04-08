{self, ...}: {
  flake.nixosModules.desktop = {pkgs, sysPkgs, ...}: {
    imports = [
      self.nixosModules.gtk

      self.nixosModules.pipewire
      self.nixosModules.firefox
      self.nixosModules.chromium
    ];

    # programs.niri.enable = true;
    # programs.niri.package = sysPkgs.niri;

    # preferences.autostart = [sysPkgs.quickshellWrapped];
    preferences.autostart = [sysPkgs.noctalia-shell];

    environment.systemPackages = [
      sysPkgs.terminal
      pkgs.pcmanfm
      sysPkgs.noctalia-shell
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
