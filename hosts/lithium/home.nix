{ config, pkgs, lib, ... }:

{
  programs.home-manager.enable = true; # Enabling home-manager, really useful

  home.username = "matei"; # Yes, that is my name
  home.homeDirectory = "/home/matei"; # Directory path

  home.stateVersion = "21.11"; # Version

  home.file = { # Files and stuff
    "Pictures/Wallpaper".source = ../../config/wallpaper;
    ".bin".source = ../../config/bin;
    ".local/share/applications/ARandr.desktop".source = ../../config/applications/ARandr.desktop;
    ".local/share/applications/Arduino.desktop".source = ../../config/applications/Arduino.desktop;
    ".local/share/applications/Aseprite.desktop".source = ../../config/applications/Aseprite.desktop;
    ".local/share/applications/Audacity.desktop".source = ../../config/applications/Audacity.desktop;
    ".local/share/applications/Baobab.desktop".source = ../../config/applications/Baobab.desktop;
    ".local/share/applications/Bleachbit.desktop".source = ../../config/applications/Bleachbit.desktop;
    ".local/share/applications/Blender.desktop".source = ../../config/applications/Blender.desktop;
    ".local/share/applications/Blueman.desktop".source = ../../config/applications/Blueman.desktop;
    ".local/share/applications/Bottles.desktop".source = ../../config/applications/Bottles.desktop;
    ".local/share/applications/Calc.desktop".source = ../../config/applications/Calc.desktop;
    ".local/share/applications/Calendar.desktop".source = ../../config/applications/Calendar.desktop;
    ".local/share/applications/Calibre.desktop".source = ../../config/applications/Calibre.desktop;
    ".local/share/applications/CDDA.desktop".source = ../../config/applications/CDDA.desktop;
    ".local/share/applications/Cava.desktop".source = ../../config/applications/Cava.desktop;
    ".local/share/applications/Chrome.desktop".source = ../../config/applications/Chrome.desktop;
    ".local/share/applications/Citra.desktop".source = ../../config/applications/Citra.desktop;
    ".local/share/applications/DCPP.desktop".source = ../../config/applications/DCPP.desktop;
    ".local/share/applications/Deemix-GUI.desktop".source = ../../config/applications/Deemix-GUI.desktop;
    ".local/share/applications/Discord.desktop".source = ../../config/applications/Discord.desktop;
    ".local/share/applications/Disks.desktop".source = ../../config/applications/Disks.desktop;
    ".local/share/applications/Dolphin.desktop".source = ../../config/applications/Dolphin.desktop;
    ".local/share/applications/EasyEffects.desktop".source = ../../config/applications/EasyEffects.desktop;
    ".local/share/applications/Emacs.desktop".source = ../../config/applications/Emacs.desktop;
    ".local/share/applications/Emacsclient.desktop".source = ../../config/applications/Emacsclient.desktop;
    ".local/share/applications/File-Roller.desktop".source = ../../config/applications/File-Roller.desktop;
    ".local/share/applications/Files.desktop".source = ../../config/applications/Files.desktop;
    ".local/share/applications/Filezilla.desktop".source = ../../config/applications/Filezilla.desktop;
    ".local/share/applications/Firefox.desktop".source = ../../config/applications/Firefox.desktop;
    ".local/share/applications/Flameshot.desktop".source = ../../config/applications/Flameshot.desktop;
    ".local/share/applications/Fractal.desktop".source = ../../config/applications/Fractal.desktop;
    ".local/share/applications/GIMP.desktop".source = ../../config/applications/GIMP.desktop;
    ".local/share/applications/Google-Earth.desktop".source = ../../config/applications/Google-Earth.desktop;
    ".local/share/applications/GWE.desktop".source = ../../config/applications/GWE.desktop;
    ".local/share/applications/GThumb.desktop".source = ../../config/applications/GThumb.desktop;
    ".local/share/applications/GZDoom.desktop".source = ../../config/applications/GZDoom.desktop;
    ".local/share/applications/Handbrake.desktop".source = ../../config/applications/Handbrake.desktop;
    ".local/share/applications/Hexchat.desktop".source = ../../config/applications/Hexchat.desktop;
    ".local/share/applications/HTop.desktop".source = ../../config/applications/HTop.desktop;
    ".local/share/applications/Impress.desktop".source = ../../config/applications/Impress.desktop;
    ".local/share/applications/Inkscape.desktop".source = ../../config/applications/Inkscape.desktop;
    ".local/share/applications/KDenLive.desktop".source = ../../config/applications/KDenLive.desktop;
    ".local/share/applications/Keychain.desktop".source = ../../config/applications/Keychain.desktop;
    ".local/share/applications/Kid3.desktop".source = ../../config/applications/Kid3.desktop;
    ".local/share/applications/Krita.desktop".source = ../../config/applications/Krita.desktop;
    ".local/share/applications/LMMS.desktop".source = ../../config/applications/LMMS.desktop;
    ".local/share/applications/Lutris.desktop".source = ../../config/applications/Lutris.desktop;
    ".local/share/applications/Mail.desktop".source = ../../config/applications/Mail.desktop;
    ".local/share/applications/Minecraft.desktop".source = ../../config/applications/Minecraft.desktop;
    ".local/share/applications/Minetest.desktop".source = ../../config/applications/Minetest.desktop;
    ".local/share/applications/MPDevil.desktop".source = ../../config/applications/MPDevil.desktop;
    ".local/share/applications/NCDU.desktop".source = ../../config/applications/NCDU.desktop;
    ".local/share/applications/NCMPCPP.desktop".source = ../../config/applications/NCMPCPP.desktop;
    ".local/share/applications/Neovim.desktop".source = ../../config/applications/Neovim.desktop;
    ".local/share/applications/Nethack.desktop".source = ../../config/applications/Nethack.desktop;
    ".local/share/applications/Nvidia-Settings.desktop".source = ../../config/applications/Nvidia-Settings.desktop;
    ".local/share/applications/OBS.desktop".source = ../../config/applications/OBS.desktop;
    ".local/share/applications/Obsidian.desktop".source = ../../config/applications/Obsidian.desktop;
    ".local/share/applications/Osu.desktop".source = ../../config/applications/Osu.desktop;
    ".local/share/applications/Pavucontrol.desktop".source = ../../config/applications/Pavucontrol.desktop;
    ".local/share/applications/PCSX2.desktop".source = ../../config/applications/PCSX2.desktop;
    ".local/share/applications/Picard.desktop".source = ../../config/applications/Picard.desktop;
    ".local/share/applications/Project-Brutality.desktop".source = ../../config/applications/Project-Brutality.desktop;
    ".local/share/applications/QBittorrent.desktop".source = ../../config/applications/QBittorrent.desktop;
    ".local/share/applications/Ranger.desktop".source = ../../config/applications/Ranger.desktop;
    ".local/share/applications/Retroarch.desktop".source = ../../config/applications/Retroarch.desktop;
    ".local/share/applications/Roblox.desktop".source = ../../config/applications/Roblox.desktop;
    ".local/share/applications/RPCS3.desktop".source = ../../config/applications/RPCS3.desktop;
    ".local/share/applications/Solaar.desktop".source = ../../config/applications/Solaar.desktop;
    ".local/share/applications/Soulseek.desktop".source = ../../config/applications/Soulseek.desktop;
    ".local/share/applications/Spotify.desktop".source = ../../config/applications/Spotify.desktop;
    ".local/share/applications/Steam.desktop".source = ../../config/applications/Steam.desktop;
    ".local/share/applications/SRM.desktop".source = ../../config/applications/SRM.desktop;
    ".local/share/applications/Super-Tux-Kart.desktop".source = ../../config/applications/Super-Tux-Kart.desktop;
    ".local/share/applications/Teams.desktop".source = ../../config/applications/Teams.desktop;
    ".local/share/applications/Upscayl.desktop".source = ../../config/applications/Upscayl.desktop;
    ".local/share/applications/Virt-manager.desktop".source = ../../config/applications/Virt-manager.desktop;
    ".local/share/applications/VSCode.desktop".source = ../../config/applications/VSCode.desktop;
    ".local/share/applications/VLC.desktop".source = ../../config/applications/VLC.desktop;
    ".local/share/applications/Wezterm.desktop".source = ../../config/applications/Wezterm.desktop;
    ".local/share/applications/Winetricks.desktop".source = ../../config/applications/Winetricks.desktop;
    ".local/share/applications/Writer.desktop".source = ../../config/applications/Writer.desktop;
    ".local/share/applications/XScreensaver.desktop".source = ../../config/applications/XScreensaver.desktop;
    ".local/share/applications/Yuzu.desktop".source = ../../config/applications/Yuzu.desktop;
    ".local/share/applications/Zathura.desktop".source = ../../config/applications/Zathura.desktop;
    ".local/share/applications/Zeal.desktop".source = ../../config/applications/Zeal.desktop;
    ".local/share/applications/Zotero.desktop".source = ../../config/applications/Zotero.desktop;
    ".local/share/applications/Zynaddsubfx.desktop".source = ../../config/applications/Zynaddsubfx.desktop;
    
    ".config/discocss/custom.css".source = ../../config/discocss/custom.css;
    ".mbsyncrc".source = ../../config/mbsyncrc;
    ".Xresources".source = ../../config/xresources;
    ".zshrc".source = ../../config/zshrc;
    ".config/touchegg/touchegg.conf".source =
      ../../config/touchegg/touchegg.conf;

    ".config/gzdoom/gzdoom.ini".source = ../../config/gzdoom/gzdoom.ini;

    ".config/awesome".source = ../../config/awesome;
    ".config/bspwm".source = ../../config/bspwm;
    ".config/btop".source = ../../config/btop;
    ".config/cava".source = ../../config/cava;
    ".config/kmonad".source = ../../config/kmonad;
    ".config/mpd".source = ../../config/mpd;
    ".config/ncmpcpp".source = ../../config/ncmpcpp;
    ".config/neofetch".source = ../../config/neofetch;
    ".config/picom".source = ../../config/picom;
    ".config/rofi".source = ../../config/rofi;
    ".config/sxhkd".source = ../../config/sxhkd;
    ".config/wezterm".source = ../../config/wezterm;
    ".config/zathura".source = ../../config/zathura;

    # Ranger
    ".config/ranger/rc.conf".source = ../../config/ranger/rc.conf;
    ".config/ranger/rifle.conf".source = ../../config/ranger/rifle.conf;
    ".config/ranger/scope.sh".source = ../../config/ranger/scope.sh;

    # Emacs
    ".config/emacs/init.el".source = ../../config/emacs/init.el;
    ".config/emacs/style.css".source = ../../config/emacs/style.css;
    ".config/emacs/doom-quiet-dark-theme.el".source =
      ../../config/emacs/doom-quiet-dark-theme.el;
    ".config/emacs/banner.png".source = ../../config/emacs/banner.png;

    # Vim
    ".config/nvim/init.vim".source = ../../config/nvim/init.vim;
    ".config/nvim/colors".source = ../../config/nvim/colors;
  };

  gtk = {
    enable = true;
    cursorTheme.package = pkgs.capitaine-cursors;
    cursorTheme.name = "Breeze_Snow";
    font.package = pkgs.source-sans-pro;
    font.name = "Source Sans Pro Regular";
    iconTheme.package = pkgs.papirus-icon-theme;
    iconTheme.name = "Papirus-Dark";
    theme.package = pkgs.matcha-gtk-theme;
    theme.name = "Matcha-dark-azul";
  };
}
