#!/usr/bin/env bash

# use the bash as default "sh", fixed some problems
# with e.g. third-party scripts
#sudo ln -sf /bin/bash /bin/sh

function ask_install() {
  echo
  echo
  read -p"$1 (y/n) " -n 1
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    return 1
  else
    return 0
  fi

}

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
  echo "This script must be run as root"
  echo "Plese use sudo or su"
  exit 1
fi

# use aptitude in the next steps ...
if [ \! -f $(whereis aptitude | cut -f 2 -d ' ') ] ; then
  apt-get install aptitude
fi

# update && upgrade
ask_install "upgrade your system?"
if [[ $? -eq 1 ]]; then
  aptitude update
  aptitude upgrade
fi

aptitude install \
  ntfs-3g \
  safe-rm \
  tmux \
  build-essential \
  autoconf \
  make \
  cmake \
  #mktemp \
  dialog \
  cabextract \
  zip \
  unzip \
  rar \
  unrar \
  tar \
  pigz \
  p7zip \
  p7zip-full \
  p7zip-rar \
  unace \
  bzip2 \
  gzip \
  xz-utils \
  advancecomp \
  gifsicle \
  optipng \
  pngcrush \
  pngnq \
  pngquant \
  jpegoptim \
  libjpeg-progs \
  jhead \
  coreutils  \
  findutils  \
  dlocate \
  mlocate \
  locales \
  localepurge \
  sysstat \
  tcpdump \
  colordiff \
  moreutils \
  atop \
  ack-grep \
  ngrep \
  htop \
  mytop \
  iotop \
  tree \
  ncdu \
  rsync \
  whois \
  vim \
  recode \
  exuberant-ctags \
  bash \
  bash-completion \
  xclip \
  grc \
  fontconfig \
  #ttf-freefont \
  ttf-mscorefonts-installer \
  ttf-bitstream-vera \
  ttf-dejavu \
  ttf-liberation \
  ttf-linux-libertine \
  ttf-larabie-deco \
  ttf-larabie-straight \
  ttf-larabie-uncommon \
  ttf-liberation \
  xfonts-jmk \
  strace \
  wget \
  curl \
  w3m \
  git \
  subversion \
  mercurial \
  lynx \
  nmap \
  pv \
  ucspi-tcp \
  xpdf \
  sqlite3 \
  perl \
  python \
  python-pip \
  python-dev \
  python-pygments

# try zsh?
read -p "Do you want to use the zsh-shell? (y/n) " -n 1 yesOrNo
echo
if [[ $yesOrNo =~ ^[Yy]$ ]]; then
  sudo aptitude install zsh
  chsh -s $(which zsh)
fi

# clean downloaded and already installed packages
aptitude -v clean

# update-fonts
cp -vr $( dirname "${BASH_SOURCE[0]}" )/.fonts/* /usr/share/fonts/truetype/
dpkg-reconfigure fontconfig
fc-cache -fv

# update-locate-db
echo "update-locate-db ..."
updatedb -v

