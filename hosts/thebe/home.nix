{ config, pkgs, lib, ... }:

{
  programs.home-manager.enable = true;
  programs.ncmpcpp.enable      = true;

  programs.git = {
    enable = true;
    userName = "Matei Cotocel";
    userEmail = "mcotocel@outlook.com";
  };

  home.username = "matei";
  home.homeDirectory = "/home/matei";

  home.stateVersion = "21.11";

  home.file.".zshrc".source = ../../config/zshrc;
  # Emacs
  home.file.".config/emacs/doom-quiet-dark-theme.el".source  = ../../config/emacs/doom-quiet-dark-theme.el;
  home.file.".config/emacs/doom-quiet-light-theme.el".source = ../../config/emacs/doom-quiet-light-theme.el;
  home.file.".config/emacs/emacs.org".source                 = ../../config/emacs/emacs.org;
  home.file.".config/emacs/init.el".source                   = ../../config/emacs/init.el;
  home.file.".config/emacs/style.css".source                 = ../../config/emacs/style.css;
  home.file.".config/emacs/etc/private.el".source            = ../../config/emacs/private.el;
}
