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

# Install build tools for Sofa
RUN apt-get install -y \
    build-essential \
    software-properties-common \
    gcc-11 \
    cmake \
    ninja-build \
    ccache

# Install dependencies for Sofa
RUN apt-get install -y \
    libtinyxml2-dev \
    libopengl0 \
    libboost-all-dev \
    python3.10-dev \
    pybind11-dev \
    python3.10-distutils

RUN curl -L https://bootstrap.pypa.io/pip/get-pip.py > /tmp/get-pip3.py && \
    python3.10 /tmp/get-pip3.py && \
    python3.10 -m pip install --upgrade pip && \
    python3.10 -m pip install numpy scipy pybind11==2.9.1

RUN apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libtiff-dev \
    libglew-dev \
    zlib1g-dev \
    libeigen3-dev

# Install plugins for Sofa
RUN apt-get install -y \
    libcgal-dev \
    libcgal-qt5-dev \
    liboce-ocaf-dev \
    libassimp-dev \
    # nvidia-cuda-toolkit
    libavcodec-dev \
    libavformat-dev \
    libavutil-dev \
    libswscale-dev \
    libblas-dev \
    liblapack-dev

RUN groupadd -g $GID $GROUPNAME && \
    useradd -m -s /bin/bash -u $UID -g $GID $USERNAME
USER $USERNAME
WORKDIR /home/$USERNAME/

RUN mkdir -p /home/$USERNAME/sofa && \
    cd /home/$USERNAME/sofa && \
    git clone -b v23.12 https://github.com/sofa-framework/sofa.git sofa/src
