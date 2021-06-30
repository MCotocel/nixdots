{ config, pkgs, lib, ... }:

{
  programs.home-manager.enable = true;
  programs.ncmpcpp.enable      = true;

  home.username = "matei";
  home.homeDirectory = "/Users/matei";

  home.stateVersion = "21.11";

  home.packages = with pkgs; [
    emacs
    mpd
    ncmpcpp
    neofetch
    neovim
    zsh
  ];

  home.file.".zshrc".source        = ./zshrc;
}
