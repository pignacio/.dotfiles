#! /bin/bash
set -u

. $CLONE_DIR/tools/log.sh;

backupAndLink() {
  src=$1;
  dst=$2;
  if [ ! -e "$src" ]; then
    log_error "Invalid source for link: '${src}'"
    return
  fi
  if [ -e "$dst" -o -h "$dst" ]; then
    if [[ "$(readlink -f $dst)" == "$(readlink -f $src)" ]]; then
      log_info "$dst already points to $src. Skipping"
      return
    fi
    rpath="$dst.old.$RANDOM"
    log_info "Found '$dst'. Moving to $rpath"
    mv "$dst" "$rpath"
  fi
  log_title "Linking $dst -> $src"
  ln -s "$src" "$dst"
}
