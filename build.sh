#!/bin/sh

SRPMDIR=/var/www/html/
REPODIR=/usr/local/MoxieLogic

mkdir -p $REPODIR/x86_64

echo "BUILD SCRIPT"

RPMCHECK=`find $REPODIR/x86_64 -name moxielogic-*binutils*`
if test -z "$RPMCHECK"; then

  rpmbuild --rebuild $SRPMDIR/moxielogic-moxie-elf-binutils*src.rpm;
  rpmbuild --rebuild $SRPMDIR/moxielogic-moxie-elf-gdb*src.rpm;
  mv /root/rpmbuild/RPMS/x86_64/* $REPODIR/x86_64

else

  RPMCHECK=`find $REPODIR/x86_64 -name bootstrap-*`
  if test -z "$RPMCHECK"; then

    yum install -y moxielogic-moxie-elf-binutils;
    rpmbuild --rebuild $SRPMDIR/bootstrap-moxie-elf-gcc*src.rpm;
    rpm -hiv /root/rpmbuild/RPMS/x86_64/bootstrap*
    rpmbuild --rebuild dist/moxielogic-moxie-elf-newlib*src.rpm;
    mv /root/rpmbuild/RPMS/x86_64/* $REPODIR/x86_64
    mv /root/rpmbuild/RPMS/noarch/* $REPODIR/noarch

  else

      RPMCHECK=`find $REPODIR/x86_64 -name gcc-*`
      if test -z "$RPMCHECK"; then

	yum install -y moxielogic-moxie-elf-newlib moxielogic-moxie-elf-binutils;
        rpmbuild --rebuild $SRPMDIR/moxielogic-moxie-elf-gcc*src.rpm;
	mv /root/rpmbuild/RPMS/x86_64/* $REPODIR/x86_64;

      fi
  fi

fi

createrepo $REPODIR	
	

