{ config, pkgs, ... }:


let
  kmonad =  import ../../derivations/kmonad.nix;
in {
  environment = {
    systemPackages = with pkgs; [
      arduino # I mess around with it occasionally
      aria # For downloading stuff
      bash # Gotta have bash
      bat # Cat but better
      cava # Move to audio
      cmake # Necessary
      coreutils # Necessary
      cowsay # My machine cannot run without this
      direnv # Need to implement this sometime
      emacs # The best text editor
      #emacsPgtkNativeComp # The better best text editor
      emacs-all-the-icons-fonts # Fonts for Emacs
      exa # ls but better
      fd # Find but better
      feh # Image viewer for the terminal
      ffmpeg # I deal with a lot of videos, okay?
      file # No more asking yourself what file it is
      fzf # Fuzzy finder, pretty useful
      gcc # Necessary
      gh # Github's CLI tool
      git # Use it every day
      gource # Nice for visualising repo history
      gnumake # Make command
      handbrake # Again, I deal with videos
      htop # Why is my laptop so hot? Oh yeah I'm compiling 20 programs while running two games
      ifuse # Also for connecting my phone
      imagemagick # Really useful for scripts
      ispell # Spell checking
      isync # For mail
      jq # For when you have to deal with json
      kmonad # Remapping keys
      libimobiledevice # For connecting my phone
      lshw # Diagnostic time!
      lua # Big fan of AwesomeWM
      lynis # Security audits. Although passwordless doas probably undermines all of it
      manix # Nix help
      mesa-demos # Checking if my GPU works
      mu # For mail
      ncdu # What the hell is taking up so much disk space? Oh.
      neofetch # Everyone loves neofetch
      neovim # The second-best editor. For when Emacs doesn't work
      nix-linter # Lint Nix files
      nodejs # Some programs need it
      nvd # Package version diff tool for Nix
      nvtop # Top, but for nvidia
      onefetch # Neofetch but for git repos
      openimagedenoise # Denoising images
      openjdk # Java
      pciutils # I love diagnosing my system
      ps_mem # (Why is Emacs using so much RAM?)
      python311 # I know Python better than I know most languages
      ranger # Terminal file manager
      ruby # That one language
      ripgrep # Grep but better
      shellcheck # Checking my crappy shell code
      speedtest-cli # Testing my internet speed from the terminal
      sqlite # Databases and stuff
      sublime4 # A cool text editor
      tmux # A terminal multiplexer
      tokei # Counting lines of code
      trash-cli # Trash instead of delete
      ueberzug # Images in terminal (again for some reason)
      unzip # For unzipping archives
      usbmuxd # Yet again, for connecting my phone
      vim # The original (not quite)
      vscode # For emergencies
      wget # For downloading web pages and stuff
      xorg.xev # Good for scripts
      youtube-dl # For downloading videos
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
