FROM haskell:7.8

# install vim tooling
RUN apt-get update \
 && apt-get install -y sudo tree git vim curl wget build-essential apt-transport-https \
      # for vim extensions
      exuberant-ctags libcurl4-openssl-dev \
 && apt-get clean

# install stack
RUN curl -sSL https://get.haskellstack.org/ | sh

# Haskell Vim setup
ADD install.sh /install.sh
RUN /bin/bash /install.sh
