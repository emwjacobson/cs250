FROM ubuntu:22.04

ENV AFL_AUTORESUME=1

RUN apt update \
  && apt -y upgrade \
  && DEBIAN_FRONTEND=noninteractive apt install -y build-essential libc6-dev libc6-dev-i386 \
    gcc-multilib g++-multilib python2 python2-dev cmake curl \
    python3-dev automake git flex bison libglib2.0-dev libpixman-1-dev python3-setuptools cargo libgtk-3-dev \
    lld-14 llvm-14 llvm-14-dev clang-14 ninja-build \
    gcc-12 gcc-12-plugin-dev libstdc++-12-dev \
    z3 \
  && rm -rf /var/lib/apt/lists/*
RUN curl https://bootstrap.pypa.io/pip/2.7/get-pip.py -o get-pip.py \
  && python2 get-pip.py
RUN python2 -m pip install xlsxwriter pycrypto defusedxml pyyaml matplotlib

# Create Symbolic Link so all references to `python` resolve to `python2`
RUN ln -s /usr/bin/python2 /usr/bin/python

RUN mkdir /persistent

WORKDIR /cb-multios

COPY ./build_scripts ./build_scripts

RUN ["/bin/bash", "./build_scripts/afl.sh"]
RUN ["/bin/bash", "./build_scripts/symcc.sh"]
RUN ["/bin/bash", "./build_scripts/symqemu.sh"]

COPY ./scripts ./scripts

WORKDIR /cb-multios/scripts

CMD ["/bin/bash", "exploit.sh"]
