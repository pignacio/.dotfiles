#!/bin/bash

set -u

. $CLONE_DIR/tools/log.sh
. $CLONE_DIR/tools/backup.sh

log_title "Setting up compleat usages"

USAGES_DIR=$CLONE_DIR/compleat/usages
COMPLEAT_DIR=$HOME/.compleat

backupAndLink $USAGES_DIR $COMPLEAT_DIR
