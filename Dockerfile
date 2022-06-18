# Using Ubuntu base image modified for Docker-friendliness
# https://github.com/phusion/baseimage-docker
FROM phusion/baseimage:bionic-1.0.0

ENV TERM=xterm
ENV LANG=ru_RU.UTF-8
ENV DEBIAN_FRONTEND=noninteractive
ENV JAVA_HOME=/usr/lib/jvm/jdk-14.0.2
ENV PATH $PATH:$JAVA_HOME/bin

ADD jdk /jdk
RUN locale-gen ru_RU && locale-gen ru_RU.UTF-8 && dpkg-reconfigure locales
RUN apt-get -qqy update && apt-get -yqq upgrade \
&& apt-get -qqy install software-properties-common \
screen wget curl vim mc mysql-client zip unzip bzip2
RUN apt-get install -qqy libasound2-dev
RUN dpkg -i /jdk/jdk-14.0.2*.deb
#RUN ln -sf /etc/ssl/certs/java/cacerts $(readlink -f /usr/bin/java | sed "s:/bin/java::")/lib/security/cacerts
RUN apt-get -qqy install python-dateutil
RUN rm -rf /var/lib/{apt,cache,log}/ \
&& apt-get -qqy autoclean

#CMD ["/sbin/my_init"]
