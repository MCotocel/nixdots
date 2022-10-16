# Lenovo Legion 5

UEFI enabled, with swap partition

## Setup

### Disks

`<disk>` is your disk. For example, on my device it's `sda`

```sh
parted /dev/<disk> -- mklabel gpt                  # Partition table
parted /dev/<disk> -- mkpart primary 512MiB -8GiB  # Root partition
parted /dev/<disk> -- mkpart linux-swap -8GiB 100% # Swap partition
parted /dev/<disk> -- mkpart ESP fat32 1MiB 512MiB # Boot partition
parted /dev/<disk> -- set 3 esp on
```

### Formatting

`<disk#>` is your disk, and the partition

```sh
mkfs.ext4 -L nixos /dev/<disk#>     # Root partition
mkswap -L swap /dev/<disk#>         # Swap partition
mkfs.fat -F 32 -n boot /dev/<disk#> # EFI partition
```

### Mounting

```sh
mount /dev/disk/by-label/nixos /mnt
mkdir /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
swapon /dev/disk/by-label/swap
```
