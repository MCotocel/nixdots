{
  description = "Doom mod";

  inputs = {
    brutality.url = "https://codeload.github.com/pa1nki113r/Project_Brutality/zip/refs/heads/master";
    glory.url = "https://brutalrepository.pl/index.php/downloads/project-brutality/others?task=download.send&id=7&catid=5&m=0";
    brutality.flake = false;
    glory.flake = false;
  };

  outputs = { self, nixpkgs, brutality, glory }: {

    packages.x86_64-linux.brutality = nixpkgs.legacyPackages.x86_64-linux.writeShellApplication {
      name = "brutality";
      text = ''
        gzdoom -file ${brutality} -file ${glory}
      '';
    };

    defaultPackage.x86_64-linux = self.packages.x86_64-linux.brutality;

  };
}
