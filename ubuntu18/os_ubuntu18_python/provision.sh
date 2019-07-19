#!/bin/bash
##set -eux


# パッケージのインストール時に、対話形式のユーザーインタフェースを抑制する
export DEBIAN_FRONTEND=noninteractive

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


### pyenv
git clone https://github.com/yyuu/pyenv.git ~/.pyenv

# Add init script to ~/.profile
echo 'export PYENV_ROOT=$(echo ~/.pyenv)' >> ~/.profile
echo 'export PATH="${PYENV_ROOT}/bin:$PATH"' >> ~/.profile
echo 'eval "$(pyenv init -)"' >> ~/.profile
. ~/.profile


### pyenv-virtualenv
git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.profile
. ~/.profile


pyenv install 3.6.8
pyenv virtualenv 3.6.8 py368
pyenv global py368

pip install jupyterLab numpy pandas matplotlib bokeh

mkdir /opt/scripts
echo "jupyter lab --ip=0.0.0.0 --allow-root --no-browser" > /opt/scripts/start_jupyterLab.sh
chmod +x /opt/scripts/start_jupyterLab.sh


### Clean
apt clean
apt autoremove

shopt -s dotglob
rm -rf /tmp/*
