#!/bin/bash

set -u

. $CLONE_DIR/tools/log.sh;
. $CLONE_DIR/tools/backup.sh;


log_title "Replacing existing vim config..."
backupAndLink $CLONE_DIR/vim/.vimrc ~/.vimrc
backupAndLink $CLONE_DIR/vim/.vim ~/.vim


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

log_title "Installing vim templates"
for template_file in $(ls $CLONE_DIR/vim/files/templates); do
  src="$CLONE_DIR/vim/files/templates/$template_file"
  dst="$HOME/.$template_file"
  backupAndLink "$src" "$dst"
done

YCM_INSTALL_FLAG=$FLAGS_DIR/vim-ycm-install
if [[ ! -f "$YCM_INSTALL_FLAG" ]]; then
  log_title "Installing YouCompleteMe"
  (cd ~/.vim/bundle/YouCompleteMe && ./install.sh --clang-completer && touch $YCM_INSTALL_FLAG)
else
  log_info "YouCompleteMe is already installed (flag:$YCM_INSTALL_FLAG)"
fi
