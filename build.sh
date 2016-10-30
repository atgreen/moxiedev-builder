#!/bin/sh

SRPMDIR=/var/www/html/
REPODIR=/usr/local/MoxieLogic

mkdir -p $REPODIR/x86_64

echo "BUILD SCRIPT"

RPMCHECK=`find $REPODIR/x86_64 -name moxielogic-*binutils*`
if test -z $RPMCHECK; then

  rpmbuild --rebuild $SRPMDIR/moxielogic-moxie-elf-binutils*src.rpm;
  rpmbuild --rebuild $SRPMDIR/moxielogic-moxie-elf-gdb*src.rpm;
  mv /root/rpmbuild/RPMS/x86_64/* $REPODIR/x86_64

else

  RPMCHECK=`find $REPODIR/x86_64 -name bootstrap-*`
  if test -z $RPMCHECK; then

    yum install -y moxielogic-moxie-elf-binutils
    rpmbuild --rebuild $SRPMDIR/bootstrap-$i-gcc*src.rpm;
    rpm -hiv /root/rpmbuild/RPMS/x86_64/bootstrap*
    rpmbuild --rebuild dist/moxielogic-$i-newlib*src.rpm;
    mv /root/rpmbuild/RPMS/x86_64/* $REPODIR/x86_64
    mv /root/rpmbuild/RPMS/noarch/* $REPODIR/noarch
    
  fi

fi

createrepo $REPODIR	
	

