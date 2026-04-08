{
  inputs,
  self,
  lib,
  ...
}: {
  flake.nixosConfigurations.hyperv = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.hostVm
      self.nixosModules.hostVmHardware
    ];
  };

  flake.nixosModules.hostVm = {pkgs, ...}: {
    imports = [
      self.nixosModules.coresys
      self.nixosModules.base
      self.nixosModules.general
      self.nixosModules.desktop

      #      self.nixosModules.discord
      #      self.nixosModules.gimp
      #      self.nixosModules.telegram
      #      self.nixosModules.youtube-music

      #      self.nixosModules.gaming

      #      self.nixosModules.powersave
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "nixvm";

    networking.networkmanager.enable = true;

    #    programs.niri.enable = true;
    #    programs.niri.package = self.packages.${pkgs.system}.niri;

    services.openssh.enable = true;
    services.openssh.settings = {
      # PasswordAuthentication = false;
      # PermitRootLogin = "no";
    };

    boot.kernelPackages = pkgs.linuxPackages_latest;
    system.stateVersion = "25.11";
  };
}
