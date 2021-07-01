# Snowstorm

Virtual machine to test NixOS in.

UEFI enabled, no swap partition.

## Setup

### Disks

`<disk>` is your disk. For example, in my VM it's `sda`

```sh
parted /dev/<disk> -- mklabel gpt                  # Partition table
parted /dev/<disk> -- mkpart primary 512MiB 100%   # Root partition
parted /dev/<disk> -- mkpart ESP fat32 1MiB 512MiB # Boot partition
parted /dev/<disk> -- set 2 esp on
```

### Formatting

`<disk#>` is your disk, and the partition

```sh
mkfs.ext4 -L nixos /dev/<disk#>     # Root partition
mkfs.fat -F 32 -n boot /dev/<disk#> # EFI partition
```

### Mounting

```sh
mount /dev/disk/by-label/nixos /mnt
mkdir /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
```
