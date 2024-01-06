{ config, ... }:

{
  home.file.".config/gtklock.css".text = ''
      window {
         background-image: url("../Pictures/Wallpaper/Plain.png");
         background-size: cover;
         background-repeat: no-repeat;
         background-position: center;
         background-color: black;
      }
  '';
}
