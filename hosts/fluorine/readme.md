# Raspberry Pi 4

No swap partition

## Setup

### Disks

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
