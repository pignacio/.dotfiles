#!/bin/bash
set -u

. $CLONE_DIR/tools/log.sh;
. $CLONE_DIR/tools/apt.sh;

log_title "Installing google-mock"
install google-mock

if [ -e "/usr/lib/libgmock.a" ]; then
  log_info "Google mock is already compiled."
else
  log_title "Configuring gmock"
  (cd /usr/src/gmock && sudo cmake .)
  log_title "Compiling gmock"
  (cd /usr/src/gmock && sudo make)
  log_title "Linking compiled gmock/gtest libraries"
  find /usr/src/gmock -name "*.a" -exec sudo ln -s {} /usr/lib \;
fi
