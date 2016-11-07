FROM atgreen/moxielogic-builder-f24

MAINTAINER green@moxielogic.org

ADD Moxie_Logic.repo /etc/yum.repos.d/Moxie_Logic.repo
ADD build.sh /root/build.sh
CMD bash
