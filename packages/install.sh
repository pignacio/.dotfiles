#!/bin/bash

. $CLONE_DIR/tools/log.sh;
. $CLONE_DIR/tools/apt.sh;

log_title "Installing some packages"
install $(cat $(dirname $0)/packages)