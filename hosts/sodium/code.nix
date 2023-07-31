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
      bash # Gotta have bash
      bat # Cat but better
      emacs-unstable # The best text editor
      emacs-all-the-icons-fonts # Fonts for Emacs
      exa # ls but better
      htop # Why is my laptop so hot? Oh yeah I'm compiling 20 programs while running two games
      ifuse # For connecting my phone
      imagemagick # Really useful for scripts
      libimobiledevice # For connecting my phone
      libsecret # For passwords
      lshw # Diagnostic time!
      lynis # Security audits. Although passwordless doas probably undermines all of it
      mesa-demos # Checking if my GPU works (It does (Thanks Nvidia))
      ncdu # What the hell is taking up so much disk space? Oh.
      neofetch # Everyone loves neofetch
      neovim # The second-best editor. For when Emacs doesn't work
      nix-index # Locate nix packages
      nix-tree # Check dependencies
      openai-whisper # Speech to text
      openjdk # Java
      pciutils # I love diagnosing my system
      ps_mem # (Why is Emacs using so much RAM?)
      speedtest-cli # Testing my internet speed from the terminal
      smartmontools # Monitor the health of hard drives
      tmux # A terminal multiplexer
      trash-cli # Trash instead of delete
      tree-sitter # Better highlighting
      vim # The original (not quite)
      xorg.xev # Good for scripts
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

      vim = "emacsclient -c";
      vi = "emacsclient -c";

      purge = "doas sync; echo 3 | doas tee /proc/sys/vm/drop_caches";

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
