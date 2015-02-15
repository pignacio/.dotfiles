#! /bin/bash
set -u

. $CLONE_DIR/tools/log.sh;

backupAndLink() {
  fname=$1
  subdir=$2
  fpath="$HOME/$fname"
  src=$CLONE_DIR/$subdir/$fname
  log_info "Configuration file for $subdir: $fname"
  if [ -e "$fpath" -o -h "$fpath" ]; then
    if [[ "$(readlink -f $fpath)" == "$(readlink -f $src)" ]]; then
      log_info "$fpath already points to $src. Skipping"
      return
    fi
    rpath="$fpath.old"
    log_info "Found '$fpath'. Moving to $rpath"
    mv $fpath $rpath
  fi
  log_title "Linking $fpath -> $src"
  ln -s $src $fpath
}
