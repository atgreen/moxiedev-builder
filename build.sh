#!/bin/sh

SRPMDIR=/var/www/html/
REPODIR=/usr/local/MoxieLogic

mkdir -p $REPODIR/x86_64
mkdir -p $REPODIR/noarch

echo "BUILD SCRIPT"

RPMCHECK=`find $REPODIR/x86_64 -name moxielogic-*binutils*`
if test -z "$RPMCHECK"; then

  rpmbuild --rebuild $SRPMDIR/moxielogic-moxie-elf-binutils*src.rpm;
  rpmbuild --rebuild $SRPMDIR/moxielogic-moxie-elf-gdb*src.rpm;
  mv /root/rpmbuild/RPMS/x86_64/* $REPODIR/x86_64

else

  RPMCHECK=`find $REPODIR/noarch -name moxielogic-*newlib*`
  if test -z "$RPMCHECK"; then

    yum install -y moxielogic-moxie-elf-binutils;
    rpmbuild --rebuild $SRPMDIR/bootstrap-moxie-elf-gcc*src.rpm;
    rpm -hiv /root/rpmbuild/RPMS/x86_64/bootstrap*
    rpmbuild --rebuild $SRPMDIR/moxielogic-moxie-elf-newlib*src.rpm;
    mv /root/rpmbuild/RPMS/x86_64/* $REPODIR/x86_64
    mv /root/rpmbuild/RPMS/noarch/* $REPODIR/noarch

  else

      RPMCHECK=`find $REPODIR/x86_64 -name moxielogic-*gcc-*`
      if test -z "$RPMCHECK"; then

	yum install -y moxielogic-moxie-elf-newlib moxielogic-moxie-elf-binutils;
        rpmbuild --rebuild $SRPMDIR/moxielogic-moxie-elf-gcc*src.rpm;
	mv /root/rpmbuild/RPMS/x86_64/* $REPODIR/x86_64;

	# Indicate the we are all done.
	touch $REPODIR/.done

      fi
  fi

fi

createrepo $REPODIR	
	

