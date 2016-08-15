#
# Ubuntu Dockerfile
#
# https://github.com/leoliew/docker-ubuntu
#
# Pull base image.
FROM ubuntu:14.04

MAINTAINER Leo Liu <zmliu0077@gmail.com>

#update apt source list,Backup the original configuration file
RUN cp -fp /etc/apt/sources.list /etc/apt/sources.list.back
RUN echo  '#14.04\n\
deb http://mirrors.aliyuncs.com/ubuntu/ trusty main restricted universe multiverse\n\
deb http://mirrors.aliyuncs.com/ubuntu/ trusty-security main restricted universe multiverse\n\
deb http://mirrors.aliyuncs.com/ubuntu/ trusty-updates main restricted universe multiverse\n\
deb http://mirrors.aliyuncs.com/ubuntu/ trusty-proposed main restricted universe multiverse\n\
deb http://mirrors.aliyuncs.com/ubuntu/ trusty-backports main restricted universe multiverse\n\
deb-src http://mirrors.aliyuncs.com/ubuntu/ trusty main restricted universe multiverse\n\
deb-src http://mirrors.aliyuncs.com/ubuntu/ trusty-security main restricted universe multiverse\n\
deb-src http://mirrors.aliyuncs.com/ubuntu/ trusty-updates main restricted universe multiverse\n\
deb-src http://mirrors.aliyuncs.com/ubuntu/ trusty-proposed main restricted universe multiverse\n\
deb-src http://mirrors.aliyuncs.com/ubuntu/ trusty-backports main restricted universe multiverse\n'\
> /etc/apt/sources.list

# update source
RUN apt-get update
RUN apt-get upgrade -y

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Define default command.
CMD ["bash"]
