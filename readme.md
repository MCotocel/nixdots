# Nix dotfiles

I have no idea what the hell I'm doing. I wouldn't advise you to use all of these configs

## Setup

- Get the latest minimal NixOS ISO
- Boot into the installer, setup, and mount the disks
  - Depending on which host you want to setup, you'll have to follow different instructions, each in ./hosts/<host>/readme.md
- Get a nix shell with `git` and `nix flake` set up: `nix-shell -p git nixFlakes`
- Clone these dotfiles to `/etc/nixos`: `git clone https://github.com/hlissner/dotfiles /mnt/etc/nixos`
- Install NixOS with the flake: `nixos-install --root /mnt --flake /mnt/etc/nixos#host`
  - Host is the host you want to install. A list of hosts is in ./hosts
- Reboot and change the user password
