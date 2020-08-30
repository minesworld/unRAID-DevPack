#!/bin/bash
cd $(dirname $0)
tar -xzf cpio-2.13.tgz

cd cpio-2.13
export CFLAGS="-no-pie -static"
./configure
make
make install

