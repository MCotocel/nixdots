# Nix dotfiles


## Setup

- Get the latest minimal NixOS ISO
- Boot into the installer, setup, and mount the disks
  - Depending on which host you want to setup, you'll have to follow different instructions, each in `./hosts/<host>/readme.md`
- Get a nix shell with `git` and `nix flake` set up: `nix-shell -p git nixFlakes`
- Clone these dotfiles to `/etc/nixos`: `git clone --recurse-submodules https://github.com/mcotocel/nixdots /mnt/etc/nixos`
- Install NixOS with the flake: `nixos-install --root /mnt --flake /mnt/etc/nixos#host --impure`
  - Host is the host you want to install. A list of hosts is in `./hosts`
- Reboot and change the user password
- Log in as the normal user and run `nas pull` to pull the config to your home folder
