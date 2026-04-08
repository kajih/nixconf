{self, ...}: {
  flake.nixosModules.wayland = {pkgs, sysPkgs, ...}: {
    imports = [
      self.nixosModules.desktop
      self.nixosModules.gtk
      self.nixosModules.pipewire
    ];

    # preferences.autostart = [sysPkgs.quickshellWrapped];
    preferences.autostart = [sysPkgs.noctalia-shell];

    environment.systemPackages = [
      sysPkgs.terminal
      pkgs.pcmanfm
      sysPkgs.noctalia-shell
    ];

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
