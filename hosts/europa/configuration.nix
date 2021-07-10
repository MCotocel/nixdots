{ config, pkgs, ... }:

{

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile
  environment.systemPackages = [
    pkgs.ack
    pkgs.aria
    pkgs.bash
    pkgs.bat
    pkgs.cmake
    pkgs.cmatrix
    pkgs.coreutils
    pkgs.cowsay
    pkgs.direnv
    pkgs.discocss
    pkgs.emacs
    pkgs.exa
    pkgs.fd
    pkgs.ffmpeg
    pkgs.fzf
    pkgs.gh
    pkgs.git
    pkgs.htop
    pkgs.imagemagick
    pkgs.ispell
    pkgs.isync
    pkgs.jq
    pkgs.manix
    pkgs.mpc_cli
    pkgs.mpd
    pkgs.mpv
    pkgs.mu
    pkgs.ncdu
    pkgs.ncmpcpp
    pkgs.neofetch
    pkgs.neovim
    pkgs.nethack
    pkgs.onefetch
    pkgs.python39
    pkgs.ranger
    pkgs.ripgrep
    pkgs.skhd
    pkgs.speedtest-cli
    pkgs.spicetify-cli
    pkgs.telegraf
    pkgs.telnet
    pkgs.texlive.combined.scheme-full
    pkgs.tmux
    pkgs.trash-cli
    pkgs.xquartz
    pkgs.yabai
    pkgs.youtube-dl
    pkgs.zsh
  ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/nixdots/hosts/europa/darwin-configuration.nix";

  # Disable daemon
  services.nix-daemon.enable = false;

  # Create /etc/bashrc that loads the nix-darwin environment
  programs.zsh.enable = true;  # default shell on catalina

  # Used for backwards compatibility
  system.stateVersion = 4;

  services.yabai = {
    enable = true;
    package = pkgs.yabai;
    enableScriptingAddition = false;
    config = {
      focus_follows_mouse          = "off";
      mouse_follows_focus          = "off";
      window_placement             = "second_child";
      active_window_border_topmost = "off";
      window_topmost               = "on";
      split_ratio                  = "0.50";
      auto_balance                 = "on";
      mouse_modifier               = "fn";
      mouse_action1                = "move";
      mouse_action2                = "resize";
      layout                       = "bsp";
      top_padding                  = 10;
      bottom_padding               = 10;
      left_padding                 = 10;
      right_padding                = 10;
      window_gap                   = 10;
    };

    extraConfig = ''
        yabai -m rule --add app="^System Preferences$" manage=off
        yabai -m rule --add app="^Keka$" manage=off
        yabai -m rule --add app="^Digital Color Meter$" manage=off
        yabai -m rule --add app="^Latest$" manage=off
        yabai -m rule --add app="^Stickies$" manage=off
        yabai -m rule --add app="^GIMP" manage=off
        yabai -m rule --add app="^IINA" manage=off
        yabai -m rule --add app="[eE]macs" manage=on
        skhd &
    '';
  };
}
