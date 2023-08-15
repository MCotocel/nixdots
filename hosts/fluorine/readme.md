# Raspberry Pi 4

No swap partition

# Setup

- Clone dotfiles: `git clone https://github.com/mcotocel/nixdots /etc/nixos`
- Rebuild dotfiles: `nixos-rebuild --flake /etc/nixos#fluorine --impure switch`
- Pull the config to your home: `cp -R /etc/nixos ~/nixdots`

# Issues

The Raspberry Pi 4 may not boot without a monitor connected. If this happens, the `FIRMWARE` partition of the SD card must be mounted to manually edit `config.txt` and add `hdmi_force_hotplug=1` to the `pi4` section.
