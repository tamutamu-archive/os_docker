#!/bin/bash
##set -eux


# パッケージのインストール時に、対話形式のユーザーインタフェースを抑制する
export DEBIAN_FRONTEND=noninteractive

# 日本国内のミラーサイトを使うようにし、ソースインデックスは取得しない
sed -i \
    -e 's,//archive.ubuntu.com/,//jp.archive.ubuntu.com/,g' \
    -e '/^deb-src /s/^/#/' \
    /etc/apt/sources.list


INSTALL_PACKAGES="\
    sudo \
    wget \
    language-pack-ja \
    tzdata \
    build-essential \
    libssl-dev        \
    libreadline-dev   \
    zlib1g-dev        \
    language-pack-ja  \
    openssh-server    \
    wget              \
    python            \
    zip unzip         \
    tcpdump           \
    vim               \
    git               \
    openjdk-8-jdk     \
    maven             \
    gnupg2            \
    manpages-ja manpages-ja-dev \
    iputils-ping      \
    telnet            \
    net-tools
"
apt update
apt -y upgrade
apt install -y systemd
apt install -y --no-install-recommends ${INSTALL_PACKAGES}


# ssh
sed -i.bk \
  -e 's/#PermitRootLogin.*$/PermitRootLogin yes/' \
  -e 's/#PasswordAuthentication.*$/PasswordAuthentication no/' \
  /etc/ssh/sshd_config

mkdir -p  ~/.ssh && \
touch  ~/.ssh/authorized_keys && \
chmod 600  ~/.ssh/authorized_keys && \
echo "root:root" | chpasswd


# proxy
cat << EOT >> /etc/sudoers.d/proxy_env
Defaults env_keep="http_proxy"
Defaults env_keep+="https_proxy"
Defaults env_keep+="HTTP_PROXY"
Defaults env_keep+="HTTPS_PROXY"
EOT

cat << EOT >> /etc/profile.d/proxy.sh
export http_proxy=${http_proxy}
export https_proxy=${http_proxy}
export HTTP_PROXY=${http_proxy}
export HTTPS_PROXY=${http_proxy}
EOT


# ロケールを日本語にセットするが、メッセージ出力は翻訳しない
LOCALTIME_FILE=/usr/share/zoneinfo/Asia/Tokyo
update-locale LANG=ja_JP.UTF-8 LC_MESSAGES=C

# 前のスクリプトでtzdataがインストールされていることを確認する
if [ ! -f "${LOCALTIME_FILE}" ] ; then
    echo "${LOCALTIME_FILE} does not exist."
    exit 1
fi

ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
dpkg-reconfigure tzdata


# python
apt install -y \
    zlib1g-dev \
    libbz2-dev \
    libreadline7 \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    libncurses5 \
    libncurses5-dev \
    libncursesw5


### Clean
apt clean
apt autoremove

shopt -s dotglob
rm -rf /tmp/*
