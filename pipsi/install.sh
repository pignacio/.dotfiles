#!/bin/bash

set -u

. $CLONE_DIR/tools/log.sh

log_title "Installing pipsi"
curl https://raw.githubusercontent.com/mitsuhiko/pipsi/master/get-pipsi.py | python
