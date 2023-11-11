FROM ubuntu:jammy

ENV DEBIAN_FRONTEND=noninteractive
ENV USER=chend
ENV USER_HOME=/home/${USER}

ENV TZ=Asia/Shanghai
ENV TERM=xterm-256color

RUN apt update
RUN apt install -y build-essential clang flex bison g++ gawk \
    gcc-multilib g++-multilib gettext git libncurses-dev libssl-dev \
    python3-distutils rsync unzip zlib1g-dev file wget libc6 \
    sudo vim

# Add user
RUN useradd -ms /bin/bash ${USER} && adduser ${USER} sudo && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

ENV WORKDIR=${USER_HOME}/data/openwrt
USER ${USER}

WORKDIR ${USER_HOME}/data
# RUN ls -l ${WORKDIR} || git clone https://git.openwrt.org/openwrt/openwrt.git


# RUN git checkout -f v22.03.0-rc4

# RUN ./scripts/feeds update -a
# RUN ./scripts/feeds install -a

# COPY dotconfig ${WORKDIR}/.config


