#!/usr/bin/env bash

set -e

show_usage() {
  echo "Usage: $(basename $0) takes exactly 1 argument (install | uninstall)"
}

if [ $# -ne 1 ]
then
  show_usage
  exit 1
fi

check_env() {
  if [[ -z "${RALPM_TMP_DIR}" ]]; then
    echo "RALPM_TMP_DIR is not set"
    exit 1
  
  elif [[ -z "${RALPM_PKG_INSTALL_DIR}" ]]; then
    echo "RALPM_PKG_INSTALL_DIR is not set"
    exit 1
  
  elif [[ -z "${RALPM_PKG_BIN_DIR}" ]]; then
    echo "RALPM_PKG_BIN_DIR is not set"
    exit 1
  fi
}

install() {
  wget https://github.com/RAL0S/hal/releases/download/v3.3.0-169/hal_v3.3.0-169-gd427c070be_amd64.snap -O $RALPM_TMP_DIR/hal_v3.3.0-169-gd427c070be_amd64.snap
  sudo snap install $RALPM_TMP_DIR/hal_v3.3.0-169-gd427c070be_amd64.snap --dangerous
  rm $RALPM_TMP_DIR/hal_v3.3.0-169-gd427c070be_amd64.snap
  echo "This package adds the command hal."
  echo "Run:"
  echo " - hal for the CLI"
  echo " - hal -g for the GUI"
}

uninstall() {
  sudo snap remove hal
}

run() {
  if [[ "$1" == "install" ]]; then 
    install
  elif [[ "$1" == "uninstall" ]]; then 
    uninstall
  else
    show_usage
  fi
}

check_env
run $1