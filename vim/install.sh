#!/bin/bash

set -u

. $CLONE_DIR/tools/log.sh

log_title "Installing missing vim plugins"
vim +PluginInstall +qa


INCONSOLATA_PATH="$HOME/.fonts/Inconsolata-dz for Powerline.otf"
if [ -f "$INCONSOLATA_PATH" ]; then
  log_info "Inconsolata for Powerline is already downloaded"
else
  log_title "Downloading Inconsolata for Powerline font"
  mkdir -p $(dirname "$INCONSOLATA_PATH")
  wget "https://github.com/Lokaltog/powerline-fonts/raw/master/InconsolataDz/Inconsolata-dz%20for%20Powerline.otf" -O "$INCONSOLATA_PATH"
  fc-cache
fi

for extension in py html; do
  src="$CLONE_DIR/vim/files/template.$extension"
  dst="$HOME/.vim-template:*.$extension"
  if [[ ! -e "$dst" ]]; then
    log_title "Setting up vim template for $extension"
    ln -s "$src" "$dst"
  fi
done


