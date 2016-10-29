#!/bin/sh

SRPMDIR=/var/www/html/
REPODIR=/usr/local/MoxieLogic

mkdir -p $REPODIR/x86_64

if ! test -f $REPODIR/x86_64/moxielogic-moxie-elf-*; then

  rpmbuild --rebuild $SRPMDIR/moxielogic-moxie-elf-binutils*src.rpm;
  rpmbuild --rebuild $SRPMDIR/moxielogic-moxie-elf-gdb*src.rpm;
  mv /root/rpmbuild/RPMS/x86_64/* $REPODIR/x86_64

else

  if ! test -f $REPODIR/x86_64/bootstrap*; then

    yum install moxielogic-moxie-elf-binutils
    rpmbuild --rebuild $SRPMSDIR/bootstrap-$i-gcc*src.rpm;
    rpm -hiv /root/rpmbuild/RPMS/x86_64/bootstrap*
    rpmbuild --rebuild dist/moxielogic-$i-newlib*src.rpm;
    mv /root/rpmbuild/RPMS/x86_64/* $REPODIR/x86_64
    mv /root/rpmbuild/RPMS/noarch/* $REPODIR/noarch
    
  fi

fi

createrepo $REPODIR	
	

