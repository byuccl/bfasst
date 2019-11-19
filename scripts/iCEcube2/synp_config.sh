#!/usr/bin/env bash
ICEDIR=$1
export LD_LIBRARY_PATH=$ICEDIR/sbt_backend/bin/linux/opt/synpwrap:$LD_LIBRARY_PATH
export SYNPLIFY_PATH=$ICEDIR/synpbase
export SBT_DIR=$ICEDIR/sbt_backend
