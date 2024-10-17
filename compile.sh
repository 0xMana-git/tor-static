#!/bin/bash

#clone stuff
git clone https://github.com/madler/zlib
git clone https://github.com/openssl/openssl
git clone https://github.com/libevent/libevent
git clone https://gitlab.torproject.org/tpo/core/tor
#very important: must have musl-gcc
export CC=musl-gcc

#compile zlib
cd zlib
./configure && make -j
cd ..
cd openssl
./Configure -pthread no-module no-shared && make -j
cd ..
cd libevent
./autogen.sh && ./configure && make -j
cp include .libs/include -r
cd ..
cd tor
./autogen.sh && ./configure --enable-static-tor --with-openssl-dir='../openssl' --with-libevent-dir='../libevent/.libs' --with-zlib-dir='../zlib' --disable-systemd --disable-lzma --disable-zstd && make -j
