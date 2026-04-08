{self, ...}: {
  flake.nixosModules.desktop = {pkgs, ...}: {
    imports = [
      self.nixosModules.firefox
      self.nixosModules.chromium
    ];

    # Display-server agnostic GUI tools
    environment.systemPackages = with pkgs; [
      kitty
      alacritty
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
  };
}
