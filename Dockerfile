FROM centos:7

RUN yum group install -y "Development Tools"
RUN yum install -y sudo tree git vim curl wget exuberant-ctags vim parallel

ENV PATH=/root/.local/bin:$PATH

RUN mkdir -p $HOME/.local/bin && \
    curl -sSL https://get.haskellstack.org/ | sh

ADD install.sh /install.sh
RUN /bin/bash /install.sh --no-hoogle

