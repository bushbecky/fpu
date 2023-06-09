#!/bin/bash
set -e

PREFIX=/opt/testfloat

if [ -d "$PREFIX" ]
then
  sudo rm -rf $PREFIX
fi
sudo mkdir $PREFIX
sudo chown -R $USER:$USER $PREFIX/

sudo apt-get -y install git build-essential make

if [ -d "berkeley-softfloat-3" ]
then
  rm -rf berkeley-softfloat-3
fi

if [ -d "berkeley-testfloat-3" ]
then
  rm -rf berkeley-testfloat-3
fi

git clone https://github.com/ucb-bar/berkeley-softfloat-3.git
git clone https://github.com/ucb-bar/berkeley-testfloat-3.git

cd berkeley-softfloat-3/build/Linux-x86_64-GCC
make -j$(nproc)

cd -

cd berkeley-testfloat-3/build/Linux-x86_64-GCC
make -j$(nproc)

mv -t $PREFIX testfloat testfloat_gen testfloat_ver testsoftfloat timesoftfloat
