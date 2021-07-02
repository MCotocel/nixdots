self: super: {
  lua = super.lua.override {
    packageOverrides = luaself: luaprev: {
      awestore = super.callPackage (super.fetchzip {
        url = "https://gist.github.com/mlvzk/7749304fb592bf00f1ebc0ac89aeca42/archive/f2ecd9aaf515486acb8eff3a5d134b04f2ffa370.zip";
        sha256 = "sha256-I6vzxYAurrk3SyEoVIpq5wb+h89EtDriYjMG0x8hF3M=";
      }) { luaPackages = luaself; };
    };
  };
}
