#!/bin/bash

set -u

. $CLONE_DIR/tools/log.sh

INCONSOLATA_PATH="~/.fonts/Inconsolata-dz for Powerline.otf"
if [ -f "$INCONSOLATA_PATH" ]; then
  log_info "Inconsolata for Powerline is already downloaded"
else
  log_title "Downloading Inconsolata for Powerline font"
  mkdir -p $(dirname "$INCONSOLATA_PATH")
  wget "https://github.com/Lokaltog/powerline-fonts/raw/master/InconsolataDz/Inconsolata-dz%20for%20Powerline.otf" -O "$INCONSOLATA_PATH"
  fc-cache
fi
