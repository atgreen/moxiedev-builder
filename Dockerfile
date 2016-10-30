FROM atgreen/moxielogic-repos

MAINTAINER green@moxielogic.org

RUN dnf -y install \
    gcc gcc-c++ rpm-build make patch autoconf automake \
    mpfr-devel gmp-devel libmpc-devel flex bison zlib-devel \
    python-devel texinfo ncurses-devel createrepo gperf

ADD Moxie_Logic.repo /etc/yum.repos.d/Moxie_Logic.repo
ADD build.sh /root/build.sh
CMD bash
