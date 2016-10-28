#!/bin/sh

SRPMDIR=/var/www/html/

rpmbuild --rebuild $SRPMDIR/moxielogic-moxie-elf-binutils*src.rpm;
rpmbuild --rebuild $SRPMDIR/moxielogic-moxie-elf-gdb*src.rpm;

find /root/rpmbuild

