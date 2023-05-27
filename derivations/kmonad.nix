let
  pkgs = import <nixpkgs> { };

  kmonad-bin = pkgs.fetchurl {
    url = "https://github.com/kmonad/kmonad/releases/download/0.3.0/kmonad-0.3.0-linux";
    sha256 = "4545b0823dfcffe0c4f0613916a6f38a0ccead0fb828c837de54971708bafc0b";
  };
in
pkgs.runCommand "kmonad" {}
    ''
      #!${pkgs.stdenv.shell}
      mkdir -p $out/bin
      cp ${kmonad-bin} $out/bin/kmonad
      chmod +x $out/bin/*
    ''
