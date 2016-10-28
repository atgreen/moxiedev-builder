#!/bin/sh

SRPMDIR=/var/www/html/

rpmbuild --rebuild $SRPMDIR/moxielogic-moxie-elf-binutils*src.rpm;
rpmbuild --rebuild $SRPMDIR/moxielogic-moxie-elf-gdb*src.rpm;

mkdir -p /usr/local/MoxieLogic/x86_64
mv /root/rpmbuild/RPMS/x86_64/* /usr/local/MoxieLogic/x86_64
createrepo /usr/local/MoxieLogic

