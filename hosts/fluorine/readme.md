# Raspberry Pi 4

No swap partition

# Setup

- Clone dotfiles: `git clone https://github.com/mcotocel/nixdots /etc/nixos`
- Rebuild dotfiles: `nixos-rebuild --flake /etc/nixos#fluorine --impure switch`
- Pull the config to your home: `cp -R /etc/nixos ~/nixdots`
