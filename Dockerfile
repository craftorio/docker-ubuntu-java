# Using Ubuntu base image modified for Docker-friendliness
# https://github.com/phusion/baseimage-docker
FROM phusion/baseimage

ENV "TERM=xterm"
ENV "LANG ru_RU.UTF-8"

RUN export DEBIAN_FRONTEND=noninteractive \
&& apt-get -qqy update \
&& apt-get -qqy install software-properties-common python-software-properties screen wget curl vim mysql-client unzip \
&& add-apt-repository -y ppa:webupd8team/java \
&& apt-get -qqy update \
&& echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
&& echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections \
&& apt-get -qqy install oracle-java8-installer python-dateutil \
&& locale-gen ru_RU && locale-gen ru_RU.UTF-8 && dpkg-reconfigure locales \
&& rm -rf /var/lib/{apt,cache,log}/ \
&& echo 'JAVA_HOME="/usr/lib/jvm/java-8-oracle"' >> /etc/environment \
&& apt-get -qqy autoclean

CMD ["/sbin/my_init"]
