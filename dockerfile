FROM ubuntu:focal

RUN apt-get update && apt-get install -y tmux wget git build-essential unzip

USER 0

RUN mkdir -p /root/.config/
RUN mkdir -p /root/.config/nvim/
WORKDIR /root/.config/nvim/

RUN wget https://raw.githubusercontent.com/mainak55512/mainak55512/main/init.lua

WORKDIR ../..
RUN wget https://raw.githubusercontent.com/mainak55512/mainak55512/main/.tmux.conf
RUN git clone https://github.com/tmux-plugins/tpm /root/.tmux/plugins/tpm
RUN echo "export TERM='xterm-256color'" >> /root/.bashrc
RUN . /root/.bashrc

WORKDIR ../home
RUN mkdir -p neovim

WORKDIR neovim/

RUN wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz

RUN tar -xvzf nvim-linux64.tar.gz

WORKDIR ../../usr/bin

RUN ln -s /home/neovim/nvim-linux64/bin/nvim

WORKDIR ../../home

RUN mkdir -p codes
