#!/bin/bash

#
# only used to install packages inside docker image
# not part of unraid package
#
 
yell() { echo "** $0: $*" >&2; }
die() { yell "$*"; exit 111; }
try() { "$@" || die "cannot $*"; }
#

cd $(dirname $0)
if [ -z "$( ls ./*.txz 2>/dev/null )" ]; then exit 0; fi

install() {
  echo "install ${1}"
  installpkg $1 && rm $1

  patch="${1%????}.sh"
  if [ -f $patch ]; then
    echo "patching via ${patch}"
    $patch && rm $patch
  fi
}

if [ -z "$1" ]; then
  for package in ./*.txz; do
    install $package
  done
else
  for package in $@; do
    install $package
  done
fi
