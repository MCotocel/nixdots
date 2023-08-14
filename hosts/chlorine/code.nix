{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    config = {
      user = {
        name = "Matei Cotocel";
        email = "mcotocel@outlook.com";
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      bash # Gotta have bash
      htop # Why is my laptop so hot? Oh yeah I'm compiling 20 programs while running two games
      speedtest-cli # Testing my internet speed from the terminal
      trash-cli # Trash instead of delete
      unzip # For unzipping archives
      vim # For editing text
      wget # For downloading web pages and stuff
      zsh # The better shell
    ];

    shellAliases = { # Loads of aliases
      rm = "trash";

      purge = "doas sync; echo 3 | doas tee /proc/sys/vm/drop_caches";

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
    ohMyZsh.enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };
}
