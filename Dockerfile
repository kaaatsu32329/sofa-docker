FROM ubuntu:22.04

ARG USERNAME=user
ARG GROUPNAME=user
ARG UID=1000
ARG GID=1000

RUN apt-get update && \
    apt-get upgrade -y

RUN apt-get install -y \
    curl \
    git \
    vim \
    nano \
    sudo

RUN groupadd -g $GID $GROUPNAME && \
    useradd -m -s /bin/bash -u $UID -g $GID $USERNAME
USER $USERNAME
WORKDIR /home/$USERNAME/
