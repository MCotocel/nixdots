{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      bash # Gotta have bash
      bat # Cat but better
      exa # ls but better
      git # Use it every day
      htop # Why is my laptop so hot? Oh yeah I'm compiling 20 programs while running two games
      neofetch # Everyone loves neofetch
      neovim # The second-best editor. For when Emacs doesn't work
      speedtest-cli # Testing my internet speed from the terminal
      smartmontools # Monitor the health of hard drives
      sqlite # Databases and stuff
      trash-cli # Trash instead of delete
      unzip # For unzipping archives
      wget # For downloading web pages and stuff
      zsh # The better shell
    ];

    shellAliases = { # Loads of aliases
      ls = "exa";
      la = "exa -a";
      ll = "exa -la";
      lt = "exa -lT";
      lat = "exa -laT";

      cat = "bat";

      magit = "emacsclient -c -e '(magit-status)'";
      elfeed = "emacsclient -c -e '(elfeed)'";

      rm = "trash";

      ta = "tmux attach -t";
      tn = "tmux new-session -s";
      tl = "tmux list-sessions";

      vim = "nvim";
      vi = "nvim";

      purge = "doas sync; echo 3 | doas tee /proc/sys/vm/drop_caches";

      kmonad-active = ''
        echo -e "Internal $(grep Base-layer ~/.kmonad-internal | tail -1 | sed 's/Base-layer: //')
        Cooler Master $(grep Base-layer ~/.kmonad-coolermaster | tail -1 | sed 's/Base-layer: //')"'';
    };

    variables = { # Some variables cause variables are cool
      EDITOR = "emacsclient -c --alternate-editor=nvim";
      VISUAL = "emacsclient -c --alternate-editor=nvim";
      BAT_THEME = "base16";
      XDG_CONFIG_HOME = "~/.config";
      PATH = "$HOME/.bin/:$PATH";
    };
  };

  programs.command-not-found.enable = true;

  programs.zsh = { # ZSH is cool too
    enable = true;
    ohMyZsh.enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.thefuck.enable = true;
  programs.thefuck.alias = "oh"; # Let's make it a bit more... yeah
}
