# NAME bbs-io/synchronet-build

# Using bullseye-slim, currrent stable as of 2022-05-30
FROM debian:bullseye-slim as base

ENV TERM=xterm-256color
ENV DEBIAN_FRONTEND=noninteractive

ENV SBBSCTRL=/sbbs/ctrl
ENV SBBSEXEC=/sbbs/exec

# Utilities & Runtime Pre-requisites
RUN (echo "deb http://deb.debian.org/debian/ bullseye main" > /etc/apt/sources.list.d/contrib.list) \
    && (echo "deb-src http://deb.debian.org/debian/ bullseye main" > /etc/apt/sources.list.d/contrib.list) \
    && (echo "deb http://deb.debian.org/debian/ bullseye testing" > /etc/apt/sources.list.d/contrib.list) \
    && (echo "deb-src http://deb.debian.org/debian/ bullseye testing" > /etc/apt/sources.list.d/contrib.list) \
    && (echo "deb http://deb.debian.org/debian/ bullseye contrib" > /etc/apt/sources.list.d/contrib.list) \
    && (echo "deb-src http://deb.debian.org/debian/ bullseye contrib" > /etc/apt/sources.list.d/contrib.list)

RUN apt-get update \
    && apt-get upgrade -yqq \
    && apt-get install -yqq \
    curl wget ftp openssh-client \
    nano less procps libcap2-bin \
    libarchive13 libarchive-tools \
    zip unzip arj unrar-free p7zip-full lhasa arc \
    libnspr4 sudo \
    && apt-get install -yqq \
    build-essential libarchive-dev git \
    libnspr4-dev libncurses5-dev python2 pkgconf \
    && cd /tmp \
    && (curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash) \
    && git config --global core.autocrlf false \
    && cd /tmp \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
