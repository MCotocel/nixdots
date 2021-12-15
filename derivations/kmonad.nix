let
  pkgs = import <nixpkgs> { };

  kmonad-bin = pkgs.fetchurl {
    url = "https://github.com/kmonad/kmonad/releases/download/0.4.1/kmonad-0.4.1-linux";
    sha256 = "g55Y58wj1t0GhG80PAyb4PknaYGJ5JfaNe9RlnA/eo8=";
  };
in
pkgs.runCommand "kmonad" {}
    ''
      #!${pkgs.stdenv.shell}
      mkdir -p $out/bin
      cp ${kmonad-bin} $out/bin/kmonad
      chmod +x $out/bin/*
    ''
