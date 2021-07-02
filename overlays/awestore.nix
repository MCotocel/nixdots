self: super: {
  lua = super.lua.override {
    packageOverrides = luaself: luaprev: {
      awestore = super.callPackage (super.fetchzip {
        url = "https://gist.github.com/mlvzk/7749304fb592bf001ebc0ac89aeca42/archive/fcecd9aaf515486acb8eff3a5d134b04f2ffa370.zip";
        sha256 = "sha256-IgvzxYAurrk3SyEoVIpq5wb+h89EtDriYjMG0x8hF3M=";
      }) { luaPackages = luaself; };
    };
  };
}
