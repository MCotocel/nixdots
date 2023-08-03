# Lenovo Legion 5

UEFI enabled, with no swap partition

## Setup

### Windows

If dual-booting on the same drive, make sure to shrink the Windows partition from Windows in order to provide space for Linux

### Disks

`<disk>` is your disk. For example, on my device it's `sda`

```sh
parted /dev/<disk#> -- mkpart primary 512MiB -8GiB  # Root partition
parted /dev/<disk#> -- mkpart ESP fat32 1MiB 512MiB # Boot partition
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
