FROM centos:7

RUN yum group install -y "Development Tools"
RUN yum install -y sudo tree git vim curl wget exuberant-ctags vim
RUN rpm -i http://packages.psychotic.ninja/7/base/x86_64/RPMS/par-1.52-16.el7.psychotic.x86_64.rpm

ENV PATH=/root/.local/bin:$PATH

RUN mkdir -p $HOME/.local/bin && \
    curl -sSL https://get.haskellstack.org/ | sh

ADD install.sh /install.sh
RUN /bin/bash /install.sh --no-hoogle

