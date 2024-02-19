# Steam Deck

UEFI enabled, with no swap partition

# Setup

## Disks

```sh
parted /dev/nvme0n1 -- mklabel gpt
parted /dev/nvme0n1 -- mkpart primary 512MB -8GB
parted /dev/nvme0n1 -- mkpart primary linux-swap -8GB 100%
parted /dev/nvme0n1 -- mkpart ESP fat32 1MB 512MB
parted /dev/nvme0n1 -- set 3 esp on
```

### Formatting

`<disk#>` is your disk, and the partition

```sh
mkfs.ext4 -L nixos /dev/nvme0n1p1
mkswap -L swap /dev/nvme0n1p2
mkfs.fat -F 32 -n boot /dev/nvme0n1p3
```

### Mounting

```sh
mount /dev/disk/by-label/nixos /mnt
mkdir /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
swapon /dev/nvme0n1p2
```

## Installing

- Get a shell with dependencies: `nix-shell -p git nixFlakes`
- Clone dotfiles: `git clone https://github.com/mcotocel/nixdots /mnt/etc/nixos`
- Install NixOS: `nixos-install --root /mnt --flake /mnt/etc/nixos#lithium --impure`
- Clone the config to your home: `cp -R /etc/nixos ~/nixdots`
