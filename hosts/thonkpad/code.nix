{ config, pkgs, ... }:

{
  environment = {

    systemPackages = with pkgs; [
      #emacsGit
      arduino
      aria
      atom
      bash
      bat
      cava
      cmake
      cmatrix
      coreutils
      cowsay
      direnv
      emacs
      emacs-all-the-icons-fonts
      exa
      fd
      feh
      ffmpeg
      file
      fzf
      gcc
      gh
      git
      github-desktop
      gource
      handbrake
      htop
      imagemagick
      jq
      lshw
      lua
      lynis
      neofetch
      neovim
      nodejs
      onefetch
      openjdk
      pfetch
      ps_mem
      python39
      ripgrep
      tmux
      tokei
      trash-cli
      #unityhub
      vim
      vscode
      wget
      xorg.xev
      youtube-dl
      zsh
    ispell
    isync
    manix
    mesa-demos
    mu
    ncdu
    nvd
    openimagedenoise
    pciutils
    radeontop
    ranger
    shellcheck
    speedtest-cli
    sqlite
    telnet
    ueberzug
    ];

    shellAliases = {
      ls = "exa";
      la = "exa -a";
      ll = "exa -la";
      lt = "exa -lT";
      lat = "exa -laT";

      magit = "emacsclient -c -e '(magit-status)'";
      elfeed = "emacsclient -c -e '(elfeed)'";
      
      rm = "trash";
      oh = "fuck";
      
      ta = "tmux attach -t";
      tn = "tmux new-session -s";
      tl = "tmux list-sessions";
      
      vim = "emacsclient -c";
      vi = "emacsclient -c";
      
      purge = "doas sync; echo 3 | doas tee /proc/sys/vm/drop_caches";
    };

    variables = {
      EDITOR = "emacsclient -c --alternate-editor=nvim";
      VISUAL = "emacsclient -c --alternate-editor=nvim";
      BAT_THEME = "base16";
      XDG_CONFIG_HOME = "~/.config";
      PATH = "$HOME/.bin/:$PATH";
    };
  };

  programs.command-not-found.enable = true;

  programs.zsh = {
    enable = true;
    ohMyZsh.enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.thefuck.enable = true;
  programs.thefuck.alias = "oh";
}
