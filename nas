#!/usr/bin/env bash

if ! type "doas" 2> /dev/null; then
  priv="sudo"
else
  priv="doas"
fi

function help() {
    cat <<EOF
Usage: shade [OPTION]

Options:
    help	show this text
    pull	copy configs to home directory
    push	copy configs to /etc/nixos
    rebuild	rebuilt configuration for host
    rollback	rollback to previous generation
    update      update flake
    clean       clean and garabge collect store
EOF
}

function pull() {
  echo "Pulling config from /etc/nixos..."
  rm -rf $HOME.nixdots-back
  mv $HOME/nixdots $HOME/.nixdots-bak
  cp -R /etc/nixos/ $HOME/nixdots
}

function push() {
  echo "Pushing config to /etc/nixos..."
  $priv rm -rf /etc/.nixos-bak
  $priv mv /etc/nixos /etc/.nixos-bak
  $priv cp -R $HOME/nixdots/ /etc/nixos
}

function rebuild() {
  echo "Rebuilding config"
  $priv nixos-rebuild --flake /etc/nixos#$2 switch
}

function rollback() {
  echo "Rolling back"
  $priv nixos-rebuild --rollback switch
}

function update() {
  echo "Updating flake"
  $priv nix flake update /etc/nixos
}

function clean() {
  echo "Cleaning system"
  $priv nix-collect-garbage -d
  $priv nix-store --optimise
  $priv nix-env --delete-generations old
}

function search() {
  nix search nixpkgs $2
}

case "$1" in

    pull)     pull ;;
    push)     push ;;
    rebuild)  rebuild $@ ;;
    rollback) rollback ;;
    update)   update ;;
    clean)    clean ;;
    search)   search $@ ;;

    '')      help ;;
    help)    help ;;
    *)       help ;;

esac
