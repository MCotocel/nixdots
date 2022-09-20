{
  description = "An electron based gui for the deemix library";

  inputs = {
    deemix-gui.url = "https://download.deemix.app/gui/linux-x64-latest.AppImage?filename=deemix-gui.AppImage";
    deemix-gui.flake = false;
  };

  outputs = { self, nixpkgs, deemix-gui }: {

    packages.x86_64-linux.deemix-gui = nixpkgs.legacyPackages.x86_64-linux.writeShellApplication {
      name = "deemix-gui";
      text = ''
        appimage-run ${deemix-gui}
      '';
    };

    defaultPackage.x86_64-linux = self.packages.x86_64-linux.deemix-gui;

  };
}
