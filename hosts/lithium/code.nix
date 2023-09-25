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
      arduino # I mess around with it occasionally
      aria # For downloading stuff
      bash # Gotta have bash
      bat # Cat but better
      btop # Like htop but so much better looking
      cava # I like the pretty visualisations
      cmake # Necessary
      comma # Wrapper for nix-shell and nix-index
      coreutils # Necessary
      deadnix # Check for unused nix code
      direnv # Need to implement this into my workflow sometime
      distrobox # Run another distro under NixOS
      emacs-all-the-icons-fonts # Fonts for Emacs
      eza # ls but better
      fd # Find but better
      feh # Image viewer for the terminal
      ffmpeg # I deal with a lot of videos
      file # No more asking yourself what file it is, now you can just open a terminal, navigate to the directory, and run a command instead of looking at the file extension
      fzf # Fuzzy finder, pretty useful
      gcc # Necessary
      godot_4 # Game engine
      gource # Nice for visualising repo history
      gnumake # Make.
      gnuplot # Plotting graphs
      htop # Why is my laptop so hot? Oh yeah I'm compiling 20 programs while running two games
      ifuse # For connecting my phone
      imagemagick # Really useful for scripts
      ispell # Spell checking
      isync # For mail
      jq # For when you have to deal with json
      libimobiledevice # For connecting my phone
      libsecret # For passwords
      lshw # Diagnostic time!
      lua # Big fan of AwesomeWM
      lynis # Security audits. Although passwordless doas probably undermines all of it
      manix # Nix help
      mu # For mail
      ncdu # What the hell is taking up so much disk space? Oh.
      neofetch # Everyone loves neofetch
      nix-alien # Run unpatched binaries
      nix-index # Locate nix packages
      nix-tree # Check dependencies
      nixfmt # Format Nix files
      nixos-generators # Generate NixOS outputs from configurations
      nmap # For network debugging
      nodePackages.mermaid-cli # For diagrams
      nodejs # Some programs need it
      nvd # Package version diff tool for Nix
      onefetch # Neofetch but for git repos
      openai-whisper # Speech to text
      openimagedenoise # Denoising images
      openjdk # Java
      pciutils # I love diagnosing my system
      ps_mem # (Why is Emacs using so much RAM?)
      python311Full # I know Python better than I know most languages
      ranger # Terminal file manager
      rnix-lsp # LSP server for Nix
      ripgrep # Grep but better
      shellcheck # Checking my crappy shell code
      speedtest-cli # Testing my internet speed from the terminal
      smartmontools # Monitor the health of hard drives
      sqlite # Databases and stuff
      tmux # A terminal multiplexer
      tokei # Counting lines of code
      trash-cli # Trash instead of delete
      tree-sitter # Better highlighting
      ueberzug # Images in terminal (again for some reason)
      unzip # For unzipping archives
      vim # The original (not quite)
      wget # For downloading web pages and stuff
      xorg.xev # Good for scripts
      yt-dlp # For downloading videos
      zeal # Documentation browser
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
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.thefuck.enable = true;
  programs.thefuck.alias = "oh"; # Let's make it a bit more... yeah

  programs.wireshark = {
    enable = true; # It's for network debugging I swear
    package = pkgs.wireshark;
  };
}
