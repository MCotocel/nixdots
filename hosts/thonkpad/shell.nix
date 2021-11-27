{ config, pkgs, ... }:

{
  environment = {

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
