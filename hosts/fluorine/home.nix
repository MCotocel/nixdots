{ config, pkgs, lib, ... }:

{
  programs.home-manager.enable = true; # Enabling home-manager, really useful

  home.username = "matei"; # Yes, that is my name
  home.homeDirectory = "/home/matei"; # Directory path

  home.stateVersion = "21.11"; # Version

  home.file = { # Files and stuff
    ".bin".source                           = ../../config/bin;
    ".Xresources".source                    = ../../config/xresources;
    ".zshrc".source                         = ../../config/zshrc;

    # Emacs
    ".config/emacs/init.el".source                  = ../../config/emacs/init.el;
    ".config/emacs/style.css".source                = ../../config/emacs/style.css;
    ".config/emacs/doom-quiet-dark-theme.el".source = ../../config/emacs/doom-quiet-dark-theme.el;
    ".config/emacs/banner.png".source               = ../../config/emacs/banner.png;

    # Vim
    ".config/nvim/init.vim".source = ../../config/nvim/init.vim;
    ".config/nvim/colors".source   = ../../config/nvim/colors;

    # Retroarch xorg
    ".xinitrc".source   = ../../config/retro/retro_xinitrc;
  };
}
