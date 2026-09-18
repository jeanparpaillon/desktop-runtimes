#!/bin/bash
export VSN=3.6.4
export VSN_HASH=9bffaa1ad1e07b354c21bd3324ec02fa15579f45a7d0494b3e74bc449b7333ef

if [ -z "$OPENSSL_PREFIX" ]; then
export PREFIX=/usr/local/openssl
else
export PREFIX=$OPENSSL_PREFIX
fi 

if [ -z "$ARCH" ]; then
export BUILD_DIR=_build
export BASE_DIR=..
else
export BUILD_DIR=_build/$ARCH
export BASE_DIR=../..
fi

# install openssl
echo "Build and install openssl......"
mkdir -p $PREFIX/ssl && \
    mkdir -p $BUILD_DIR && \
    cd $BUILD_DIR && \
    wget -nc https://www.openssl.org/source/openssl-$VSN.tar.gz && \
    [ "$VSN_HASH" = "$(sha256sum openssl-$VSN.tar.gz | cut -d ' ' -f1)" ] && \
    tar xzf openssl-$VSN.tar.gz && \
    cd openssl-$VSN && \
    ./Configure $ARCH --prefix=$PREFIX no-shared "$@" && \
    make clean && make depend && make && make install_sw install_ssldirs

