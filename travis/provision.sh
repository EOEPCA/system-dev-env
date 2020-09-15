#!/usr/bin/env bash

ORIG_DIR="$(pwd)"
cd "$(dirname "$0")"
BIN_DIR="$(pwd)"

trap "cd '${ORIG_DIR}'" EXIT

function install_docker() {
  if hash docker 2>/dev/null
  then
    echo Docker already installed. Skipping...
  else
    echo Installing docker...
    curl -fsSL https://get.docker.com | sh -s -
    sudo usermod -aG docker vagrant
  fi
}

function install_pip() {
  if hash pip 2>/dev/null
  then
    echo pip already installed. Skipping...
  else
    echo Installing pip...
    sudo apt-get -y install python-pip
  fi
}

function install_jq() {
  if hash jq 2>/dev/null
  then
    echo jq already installed. Skipping...
  else
    echo Installing jq...
    sudo apt-get -y install jq
  fi
}

function main() {
  mkdir -p $HOME/.local/bin
  install_docker
  install_pip
  install_jq
}

main "$@"
