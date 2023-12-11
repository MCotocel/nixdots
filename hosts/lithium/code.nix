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
      bash # Gotta have bash
      bat # Cat but better
      btop # Like htop but so much better looking
      cava # I like the pretty visualisations
      cmake # Necessary
      coreutils # Necessary
      distrobox # Run another distro under NixOS. Useful for the odd tool not available in Nix yet
      dotnet-sdk_7 # C# for assignments (not a fan)
      emacs-all-the-icons-fonts # Fonts for Emacs
      eza # ls but better
      fd # Find but better
      feh # Image viewer
      ffmpeg # I deal with a lot of videos
      gcc # Necessary
      gource # Nice for visualising repo history
      gnumake # Make.
      gnuplot # Plotting graphs
      htop # Check system status
      ifuse # For connecting my phone
      imagemagick # Really useful for scripts
      ispell # Spell checking
      jq # For when you have to deal with JSON
      libheif # For converting HEIC to JPG
      libimobiledevice # For connecting my phone
      libsecret # For passwords
      lshw # Diagnostic time!
      lynis # Security audits. Every little bit helps
      mono # .NET
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
      python311Full # I know Python best
      rnix-lsp # LSP server for Nix
      speedtest-cli # Testing my internet speed from the terminal
      smartmontools # Monitor the health of hard drives
      sqlite # Databases and stuff
      tmux # A terminal multiplexer
      tokei # Counting lines of code
      trash-cli # Trash instead of delete
      tree-sitter # Better highlighting
      unzip # For unzipping archives
      vim # The original (not quite)
      vscodium # VSCode but without Microsoft. Used only when needed
      wget # For downloading web pages and stuff
      yt-dlp # For downloading videos
    ];

    shellAliases = { # Loads of aliases
      ls = "eza";
      la = "eza -a";
      ll = "eza -la";
      lt = "eza -lT";
      lat = "eza -laT";

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

  programs.zsh = { # ZSH is cool too
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.wireshark = {
    enable = true; # It's for network debugging I swear
    package = pkgs.wireshark;
  };
}
