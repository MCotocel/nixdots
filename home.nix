{ config, pkgs, lib, ... }:

{
  programs.home-manager.enable = true;
  programs.ncmpcpp.enable      = true;

  home.username = "Matei";
  home.homeDirectory = "/Users/Matei";

  home.stateVersion = "21.11";

  home.packages = with pkgs; [
    emacs
    mpd
    ncmpcpp
    neofetch
    neovim
    skhd
    yabai
    zsh
  ];

  home.file.".config/emacs".source = ./emacs;
  home.file.".config/nvim".source  = ./nvim;
  home.file.".zshrc".source        = ./zshrc;
}
