{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    config = {
      user = {
        name = "Matei Cotocel";
        email = "mcotocel@outlook.com";
      };
      credential.helper = "${
          pkgs.git.override { withLibsecret = true; }
        }/bin/git-credential-libsecret";
    };
  };

  environment = {
    systemPackages = with pkgs; [
      aria # For downloading stuff
      bash # Gotta have bash
      bat # Cat but better
      comma # Wrapper for nix-shell and nix-index
      exa # ls but better
      fd # Find but better
      file # No more asking yourself what file it is, now you can just open a terminal, navigate to the directory, and run a command instead of looking at the file extension
      htop # Why is my laptop so hot? Oh yeah I'm compiling 20 programs while running two games
      libsecret # For passwords
      neovim # The second-best editor. For when Emacs doesn't work
      speedtest-cli # Testing my internet speed from the terminal
      smartmontools # Monitor the health of hard drives
      sqlite # Databases and stuff
      trash-cli # Trash instead of delete
      unzip # For unzipping archives
      vim # For editing text
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

      rm = "trash";

      ta = "tmux attach -t";
      tn = "tmux new-session -s";
      tl = "tmux list-sessions";

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
