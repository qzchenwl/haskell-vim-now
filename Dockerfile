FROM centos:7

ARG http_proxy
ARG https_proxy

ENV http_proxy=$http_proxy
ENV https_proxy=$https_proxy

RUN rpm -Uvh http://packages.psychotic.ninja/7/base/x86_64/RPMS/par-1.52-16.el7.psychotic.x86_64.rpm && \
    rpm -Uvh http://mirror.ghettoforge.org/distributions/gf/gf-release-latest.gf.el7.noarch.rpm && \
    rpm --import http://mirror.ghettoforge.org/distributions/gf/RPM-GPG-KEY-gf.el7

RUN yum -y remove vim-minimal vim-common vim-enhanced && \
    yum -y --enablerepo=gf-plus install vim-enhanced sudo tree git vim curl wget exuberant-ctags && \
    yum group install -y "Development Tools"


ENV PATH=/root/.local/bin:$PATH

RUN mkdir -p $HOME/.local/bin  && \
    curl -sSL https://get.haskellstack.org/ | sh

ADD install.sh /install.sh

RUN stack --resolver lts-14.12 setup
RUN ln -sv /usr/lib64/libtinfo.so.5 /usr/lib64/libtinfo.so
RUN /bin/bash /install.sh --no-hoogle

