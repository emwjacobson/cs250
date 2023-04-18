#!/bin/bash

DIR=/cb-multios

cd ${DIR}

# Get SymCC
git clone --recurse-submodules -j $(nproc) https://github.com/emwjacobson/symcc
cd symcc
git submodule update --init --recursive -j $(nproc)

# Build SymCC
mkdir build
cd build
cmake -G Ninja -DZ3_TRUST_SYSTEM_VERSION=ON -DQSYM_BACKEND=ON ..
ninja

# Install SymCC
cp sym++ /usr/bin
cp symcc /usr/bin

 Build & Install the SymCC Helper
cargo install --path ../util/symcc_fuzzing_helper --root /usr

