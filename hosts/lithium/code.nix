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
      arduino
      bash
      bat
      btop
      cava
      cmake
      coreutils
      distrobox
      dotnet-sdk_7
      emacs-all-the-icons-fonts
      eza
      fd
      feh
      ffmpeg
      gcc
      gource
      gnumake
      gnuplot
      htop
      ifuse
      imagemagick
      ipfs
      ispell
      jq
      libheif
      libimobiledevice
      libsecret
      lshw
      lynis
      mono
      neofetch
      nix-index
      nix-tree
      nixfmt
      nixos-generators
      nmap
      nodejs
      nvd
      ollama
      onefetch
      openai-whisper
      openimagedenoise
      openjdk
      pciutils
      ps_mem
      python311Full
      rnix-lsp
      speedtest-cli
      smartmontools
      sqlite
      tmux
      tokei
      trash-cli
      tree-sitter
      unzip
      vim
      wget
      yt-dlp
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
