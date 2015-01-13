#!/bin/bash
set -u

. $CLONE_DIR/tools/log.sh;
. $CLONE_DIR/tools/apt.sh;

log_title "Installing cpp stuff"

install_googe_mock() {
  install google-mock

  if [ ! -e "/usr/src/gtest" ]; then
    log_title "Soft linking gtest sources"
    sudo ln -s /usr/src/gmock/gtest /usr/src
  fi
  if [ ! -e "/usr/include/gtest" ]; then
    log_title "Soft linking gtest includes"
    sudo ln -s /usr/src/gmock/gtest/include/gtest /usr/include
  fi

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
}

install_cpplint() {
  CPPLINT_BINARY="$HOME/.local/bin/cpplint.py"

  if [ -e "$CPPLINT_BINARY" ]; then
    log_info "cpplint.py is already installed"
  else
    log_title "Installing cpplint.py"
    wget -O"$CPPLINT_BINARY" "http://google-styleguide.googlecode.com/svn/trunk/cpplint/cpplint.py"
  fi
  [ -x $CPPLINT_BINARY ] || chmod +x $CPPLINT_BINARY
}

install_googe_mock
install_cpplint
install clang-format-3.5
