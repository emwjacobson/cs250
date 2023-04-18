#!/bin/bash

DIR=/cb-multios

cd ${DIR}

# Get SymQEMU
git clone --recurse-submodules -j $(nproc) https://github.com/eurecom-s3/symqemu
cd symqemu
git submodule update --init --recursive -j $(nproc)

# Build SymQEMU
mkdir -p build
cd build
../configure \
  --audio-drv-list= \
  --disable-bluez \
  --disable-sdl \
  --disable-gtk \
  --disable-vte \
  --disable-opengl \
  --disable-virglrenderer \
  --disable-werror \
  --target-list=x86_64-linux-user \
  --enable-capstone=git \
  --symcc-source=/cb-multios/symcc \
  --symcc-build=/cb-multios/symcc/build
make -j $(nproc)

# Install SymQEMU
cd x86_64-linux-user
cp symqemu-x86_64 /usr/bin
