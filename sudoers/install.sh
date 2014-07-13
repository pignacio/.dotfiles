#!/bin/bash
set -u;

. $CLONE_DIR/tools/log.sh

NO_PASSWD_FILE=/etc/sudoers.d/nopasswd

add_sudoers_no_pass_command() {
  bin=$1
  if grep $bin $NO_PASSWD_FILE >>/dev/null; then
    log_info "'$bin' is already in $NO_PASSWD_FILE"
  else
    log_title "Adding $bin command to $NO_PASSWD_FILE"
    echo "$(whoami) $(hostname) = (root) NOPASSWD: $bin" | sudo tee -a $NO_PASSWD_FILE
  fi
}

log_title "Setting sudoers file"
add_sudoers_no_pass_command /usr/local/bin/tomb
add_sudoers_no_pass_command /usr/bin/apt-get
add_sudoers_no_pass_command /sbin/shutdown
add_sudoers_no_pass_command /sbin/reboot
add_sudoers_no_pass_command /usr/sbin/iftop
