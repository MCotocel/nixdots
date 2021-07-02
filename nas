#!/usr/bin/env bash

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
  sudo rm -rf /etc/.nixos-bak
  sudo mv /etc/nixos /etc/.nixos-bak
  sudo cp -R $HOME/nixdots/ /etc/nixos
}

function rebuild() {
  if [[ $# -ne 2 ]]; then
    echo "Please specify the host"
    exit 1
  fi
  echo "Rebuilding config"
  sudo nixos-rebuild --flake /etc/nixos#$2 switch
}

function rollback() {
  echo "Rolling back"
  sudo nixos-rebuild --rollback switch
}

function update() {
  echo "Updating flake"
  sudo nix flake update /etc/nixos
}

function clean() {
  echo "Cleaning system"
  sudo nix-collect-garbage -d
  sudo nix-store --optimise
  sudo nix-env --delete-generations old
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
