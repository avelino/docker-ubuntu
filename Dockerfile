FROM ubuntu:latest
MAINTAINER Thiago Avelino <thiago@avelino.xxx>

# avoid debconf and initrd
ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

# apt config
ADD source.list /etc/apt/sources.list
ADD 25norecommends /etc/apt/apt.conf.d/25norecommends

# upgrade distro
RUN locale-gen en_US en_US.UTF-8
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y lsb-release aptitude vim postfix
RUN apt-get install -y openssh-server 

# clean packages
RUN apt-get clean
RUN rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# make /var/run/sshd
RUN mkdir /var/run/sshd

# expose ssh port
EXPOSE 22
