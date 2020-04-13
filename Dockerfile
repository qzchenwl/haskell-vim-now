FROM ubuntu:18.04

RUN apt-get -qq update -y && \
    apt-get install -y sudo tree git vim curl wget build-essential apt-transport-https exuberant-ctags libcurl4-openssl-dev ctags vim

ENV PATH=/root/.local/bin:$PATH

RUN mkdir -p $HOME/.local/bin && \
    curl -sSL https://get.haskellstack.org/ | sh

ADD install.sh /install.sh
RUN /bin/bash /install.sh --no-hoogle

