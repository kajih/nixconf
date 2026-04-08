{
  flake.nixosModules.xfce = {pkgs, ...}: {
    # Enable the X11 windowing system
    services.xserver.enable = true;

    # Enable the XFCE Desktop Environment
    services.xserver.desktopManager.xfce.enable = true;

    # Optional but recommended additions for a polished XFCE experience
    # services.xserver.displayManager.lightdm.enable = true;

    # Environment packages specific to XFCE
    environment.systemPackages = with pkgs; [
      xfce.xfce4-pulseaudio-plugin
      xfce.xfce4-whiskermenu-plugin
      xfce.xfdashboard
    ];
  };
}
