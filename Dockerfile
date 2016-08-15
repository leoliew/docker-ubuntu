#
# Ubuntu Dockerfile
#
# https://github.com/leoliew/docker-ubuntu
#
# Pull base image.
FROM ubuntu:14.04

MAINTAINER Leo Liu <zmliu0077@gmail.com>

#
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install htop git 

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Define default command.
CMD ["bash"]
