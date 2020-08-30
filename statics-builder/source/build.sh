#!/bin/bash
yell() { echo "** $0: $*" >&2; }
die() { yell "$*"; exit 111; }
try() { "$@" || die "cannot $*"; }
#

cd $(dirname $0)
if [ -z "$( ls ./*/*.sh 2>/dev/null )" ]; then exit 0; fi

build() {
    echo "running ${1}"
    try chmod +x $1 && $1
}

if [ -z "$1" ]; then
  for buildscript in ./*/*.sh; do
    build $buildscript
  done
else
  for buildscript in $@; do
    build $buildscript
  done
fi
