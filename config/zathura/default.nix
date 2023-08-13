{ config, ... }:

{
  programs.zathura = {
    enable = true;
    extraConfig = ''
      map r reload
      map p print
      map i recolor
      map - zoom out
      map = zoom in
      map R rotate
      unmap f
      map f toggle_fullscreen
      map [fullscreen] f toggle_fullscreen
      
      # Open document in fit-width mode by default
      set adjust-open "best-fit"
      
      # One page per row by default
      set pages-per-row 1
      
      # Stop at page boundries
      set scroll-page-aware "true"
      set scroll-full-overlap 0.01
      set scroll-step 100
      
      # zoom settings
      set zoom-min 10
      set guioptions ""
      
      set font "Iosevka-15"
      
      # zathurarc-dark
      set notification-error-bg "#181e23"
      set notification-error-fg "#ff8080"
      set notification-warning-bg "#181e23"
      set notification-warning-fg "#fffe80"
      set notification-bg "#181e23"
      set notification-fg "#d5d5d5"
      
      set completion-group-bg "#181e23"
      set completion-group-fg "#d5d5d5"
      set completion-bg "#181e23"
      set completion-fg "#d5d5d5"
      set completion-highlight-bg "#1f252a"
      set completion-highlight-fg "#d5d5d5"
      
      set index-bg "#181e23" 
      set index-fg "#d5d5d5" 
      set index-active-bg "#181e23"
      set index-active-fg "#d5d5d5"
      
      set inputbar-bg "#181e23"
      set inputbar-fg "#d5d5d5"
      
      set statusbar-bg "#181e23"
      set statusbar-fg "#d5d5d5"
      
      set highlight-color "#4061cf"
      set highlight-active-color "#4061cf"
      
      set default-bg "#181e23"
      set default-fg "#d5d5d5"
      set render-loading true
      set render-loading-fg "#181e23"
      set render-loading-bg "#181e23"
      
      set recolor false
      set recolor-reverse-video true
      set recolor-keephue false
      set recolor-lightcolor "#181e23"
      set recolor-darkcolor "#ffffff"
      
      set selection-clipboard clipboard
    '';
  };
}
