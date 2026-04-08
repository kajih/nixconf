{self, ...}: {
  flake.nixosModules.coresys = {
    pkgs,
    lib,
    ...
  }: let
    sysPkgs = self.packages.${pkgs.stdenv.hostPlatform.system};
  in {
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

    environment.systemPackages = with pkgs; [
      # nix
      nil
      nixd
      statix
      alejandra
      manix
      nix-inspect
      sysPkgs.nh

      # other
      file
      unzip
      zip
      p7zip
      wget
      killall
      sshfs
      fzf
      htop
      btop
      eza
      fd
      zoxide
      dust
      ripgrep
      fastfetch
      tree-sitter
      imagemagick
      imv
      ffmpeg-full
      yt-dlp
      lazygit

      # custom tools
      sysPkgs.neovimDynamic
      sysPkgs.qalc
      sysPkgs.lf
      sysPkgs.git
      sysPkgs.jujutsu
      sysPkgs.jjui
      sysPkgs.nix-check-bin

      # global aliases
      (pkgs.writeShellScriptBin "vi" ''exec nvim "$@"'')
      (pkgs.writeShellScriptBin "vim" ''exec nvim "$@"'')
    ];

    environment.variables.EDITOR = lib.getExe sysPkgs.neovimDynamic;
  };
}
