{self, ...}: {
  flake.nixosModules.xorg = {pkgs, ...}: {
    imports = [
      self.nixosModules.desktop
      self.nixosModules.pipewire
    ];

    services.xserver.enable = true;

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
