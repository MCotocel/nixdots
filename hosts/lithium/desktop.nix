{ config, lib, pkgs, system, ... }:

{
  # We're using caps lock for something else
  services.xserver.xkb.options = "caps:none";

  # Lockscreen
  security.pam.services.gtklock = {
    text = ''
      auth sufficient pam_unix.so try_first_pass likeauth nullok
      auth sufficient	pam_fprintd.so
      auth include login
    '';
  };

  # For saving passwords and stuff
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
  programs.seahorse.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;

  # Everything is bad without it
  programs.dconf.enable = true;

  # Phone and desktop integration
  programs.kdeconnect.enable = true;

  # Mail
  services.gnome = {
    evolution-data-server.enable = true;
    gnome-settings-daemon.enable = true;
    evolution-data-server.plugins = [ pkgs.evolution-ews ];
  };
  programs.evolution.enable = true;

  # Nautilus quick look
  services.gnome.sushi.enable = true;

  # Gnome
  services.xserver = {
    enable = true;
    displayManager = {
      sessionPackages = [ pkgs.hyprland ];
      gdm.enable = true;
      gdm.wayland = true;
    };
  };

  boot.plymouth.enable = true;

  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    fontconfig.defaultFonts = {
      emoji = [ "Twitter Color Emoji" ]; # My emoji font
      monospace = [ "Iosevka Nerd Font" ]; # Best monospace font
    };
    packages = with pkgs; [
      fg-virgil # For Excalidraw drawings
      montserrat # A very nice sans serif font
      noto-fonts # Fonts
      noto-fonts-cjk-sans # For CJK languages
      noto-fonts-extra # Fonts for languages
      twitter-color-emoji # Emoji
      (nerdfonts.override {
        fonts = [ "Iosevka" ];
      }) # Nerdfonts for those cool ligatures and icons
    ];
  };

  qt.platformTheme = "gtk2";
  qt.style = "gtk2";
}
