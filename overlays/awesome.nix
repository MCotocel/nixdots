final: prev: {
  awesome = (prev.awesome.overrideAttrs (old: rec {
    src = prev.fetchFromGitHub {
      owner = "awesomeWM";
      repo = "awesome";
      rev = "149d18e0e796b3a439b1d79c5ee0c93febfcdf69";
      sha256 = "02ahbph10sd5a4gv9wizcl0pmqd08mdc47w9bd28p5bldpk4vrvm";
    };
    GI_TYPELIB_PATH = "${prev.playerctl}/lib/girepository-1.0:"
      + "${prev.upower}/lib/girepository-1.0:" + old.GI_TYPELIB_PATH;
  })).override {
    stdenv = prev.clangStdenv;
    luaPackages = prev.lua52Packages;
    gtk3Support = true;
  };
}
