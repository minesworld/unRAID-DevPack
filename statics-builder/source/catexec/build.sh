#!/bin/bash
cd $( dirname $0 )

gcc -no-pie -static -Wall -o /usr/local/bin/catexec catexec.c
