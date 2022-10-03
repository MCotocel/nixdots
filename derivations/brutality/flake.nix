{
  description = "Doom mod";

  inputs = {
    brutality.url = "https://codeload.github.com/pa1nki113r/Project_Brutality/zip/refs/heads/master";
    brutality.flake = false;
  };

  outputs = { self, nixpkgs, brutality }: {

    packages.x86_64-linux.brutality = nixpkgs.legacyPackages.x86_64-linux.writeShellApplication {
      name = "brutality";
      text = ''
        gzdoom -file ${brutality}
      '';
    };

    defaultPackage.x86_64-linux = self.packages.x86_64-linux.brutality;

  };
}
