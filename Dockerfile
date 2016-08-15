#
# Ubuntu Dockerfile
#
# https://github.com/leoliew/docker-ubuntu
#

# Pull base image.
FROM ubuntu:14.04

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Define default command.
CMD ["bash"]
