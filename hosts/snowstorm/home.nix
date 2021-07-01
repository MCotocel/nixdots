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

  home.file.".zshrc".source        = ../../config/zshrc;
}
