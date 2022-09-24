{
  description = "Doom mod";

  inputs = {
    brutal.url = "https://www.moddb.com/downloads/mirror/95667/122/b01b809c5b56bf230a184a6ac954332d/?referer=https%3A%2F%2Fwww.moddb.com%2Fmods%2Fbrutal-doom%2Fdownloads";
    brutal.flake = false;
  };

  outputs = { self, nixpkgs, brutal }: {

    packages.x86_64-linux.brutal = nixpkgs.legacyPackages.x86_64-linux.writeShellApplication {
      name = "brutal";
      text = ''
        unrar e ${brutal}
        gzdoom -file brutalv21.pk3
        rm brutalv21.pk3
        rm bd21\ changelog.txt
        rm BRUTAL\ DOOM\ MANUAL.rtf
      '';
    };

    defaultPackage.x86_64-linux = self.packages.x86_64-linux.brutal;

  };
}
