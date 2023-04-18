#!/bin/bash

DIR=/cb-multios

cd ${DIR}

# Get AFL++
git clone --recurse-submodules -j $(nproc) https://github.com/AFLplusplus/AFLplusplus/
cd AFLplusplus
git submodule init
git submodule update --init --recursive -j $(nproc)

# Install AFL++
make -j$(nproc) binary-only
make install

# Clean up some disk space...
cd ${DIR}
rm -rf AFLplusplus
