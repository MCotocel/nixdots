{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      bash # Gotta have bash
      bat # Cat but better
      btop # Like htop but so much better looking
      eza # ls but better
      fd # Find but better
      htop # Check system status
      lshw # Diagnostic time!
      neofetch # Everyone loves neofetch
      trash-cli # Trash instead of delete
      unzip # For unzipping archives
      vim # The original (not quite)
    ];

    shellAliases = { # Loads of aliases
      ls = "eza";
      la = "eza -a";
      ll = "eza -la";
      lt = "eza -lT";
      lat = "eza -laT";

      cat = "bat";

      rm = "trash";
    };

    variables = { # Some variables cause variables are cool
      EDITOR = "vim";
      VISUAL = "vim";
      BAT_THEME = "base16";
      XDG_CONFIG_HOME = "~/.config";
      PATH = "$HOME/.bin/:$PATH";
    };
  };

  programs.zsh = { # ZSH is cool too
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };
}
