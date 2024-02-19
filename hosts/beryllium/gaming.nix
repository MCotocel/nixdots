{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ # Some games
    gzdoom
    minecraft
    nethack
    qzdl
    wineWowPackages.stable
  ];

  jovian.steam = {
    enable = true;
    autoStart = true;
    user = "matei";
    useSteamOSConfig = true;
  };
}
