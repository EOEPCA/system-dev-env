#!/usr/bin/env bash

ORIG_DIR="$(pwd)"
cd "$(dirname "$0")"
BIN_DIR="$(pwd)"

trap "cd '${ORIG_DIR}'" EXIT

function install_docker() {
  if docker -v >/dev/null 2>&1
  then
    echo Docker already installed. Skipping...
  else
    echo Installing docker...
    curl -fsSL https://get.docker.com | sh -s -
    sudo usermod -aG docker vagrant
  fi
}

function install_pip() {
  if pip -V >/dev/null 2>&1
  then
    echo pip already installed. Skipping...
  else
    echo Installing pip...
    sudo apt-get -y install python-pip
  fi
}

function install_jq() {
  if jq --version >/dev/null 2>&1
  then
    echo jq already installed. Skipping...
  else
    echo Installing jq...
    sudo apt-get -y install jq
  fi
}

function main() {
  mkdir -p /home/vagrant/.local/bin
  chown -R vagrant:vagrant /home/vagrant/.local
  install_docker
  install_pip
  install_jq
}

main "$@"
