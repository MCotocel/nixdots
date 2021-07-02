{ luaPackages
, runCommand
, fetchFromGitHub
, lib
}: luaPackages.toLuaModule (runCommand "awestore" {
  src = fetchFromGitHub {
    owner = "K4rakara";
    repo = "awestore";
    rev = "5509786a1d5bc538dcdde027bd07b35bc29b0df1";
    sha256 = "sha256-VuMmEf5bCifXKHerTyFOYW4w4fXA83HM02Oj4VmQOeo=";
  };
} ''
  mkdir -p $out/share/lua/${luaPackages.lua.luaversion}
  cp -r $src/src $out/share/lua/${luaPackages.lua.luaversion}/awestore
'')
