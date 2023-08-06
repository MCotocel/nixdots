(final: prev: {
  emacs-unstable = prev.emacs-unstable.override {
    withXwidgets = true; # Mostly for the browser
    withGTK3 = true; # Makes the menus look better
  };})
