# nixdots - It somehow works!

## Setup

- Get a minimal NixOS ISO. I get the latest from [here](https://channels.nixos.org/), not that it matters, since you'll be using it for 5 minutes
- Depending on which host you want to set up, you'll have to follow different instructions, each in `./hosts/<host>/readme.md`.
- Once setup is done, use the included `nas` tool to rebuild your configuration with a single command

## Why NixOS?

- Declarative package installation and configuration management
- Lots of packages (~~80k+~~ 90k+ in nixpkgs unstable)
- Rollback of configurations
- Reliablity
- Reproducible environments

## Some notes

This is not a clean configuration. It has hardcoded user paths and arguably odd defaults. However, I don't _think_ there's any harm in using snippets from this configuration.

## Details

|             |           |
|-------------|-----------|
| Compositor  | Hyprland  |
| Browser     | Firefox   |
| Text editor | Emacs     |
| Terminal    | Alacritty |
| Widgets     | Eww       |

## Screenshots

![Desktop image 1](./assets/1.png)
![Desktop image 2](./assets/2.png)
