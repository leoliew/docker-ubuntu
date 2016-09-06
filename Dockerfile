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
deb http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse\n\
deb http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse\n\
deb http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse\n\
deb http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse\n\
deb http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse\n\
deb-src http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse\n\
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse\n\
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse\n\
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse\n\
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse\n'\
> /etc/apt/sources.list

# update source
RUN apt-get update
RUN apt-get upgrade -y

# Install base dependencies
RUN apt-get install -y -q --no-install-recommends \
        apt-transport-https \
        build-essential \
        ca-certificates \
        curl \
        git \
        libssl-dev \
        python \
        rsync \
        software-properties-common \
        wget \
        libkrb5-dev \
        python-hiredis \
        unzip \
        vim \
    && rm -rf /var/lib/apt/lists/*

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Set debconf to run non-interactively
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Define nodejs env
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 4.4.7

# Install nvm with node and npm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.31.4/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/v$NODE_VERSION/bin:$PATH

# install npm package
RUN source $NVM_DIR/nvm.sh && \
    npm -g i npm nrm && \
    nrm use taobao && \
    npm -g i sails@0.12.3 grunt-cli bower pm2 nodemon && \
    npm cache clean

# Set environment variables.
ENV HOME /root
ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# Define working directory.
WORKDIR /root

# Define default command.
CMD ["bash"]
