#!/usr/bin/env bash

ORIGINAL_PATH=/home/dasck/bin:/home/dasck/.local/bin:/home/dasck/.cargo/bin:/usr/java/jdk1.8.0_162/bin:/home/dasck/go/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/local/cuda/bin:/snap/bin:/home/dasck/.fzf/bin
BASEDIR=/drive5/runDirCKD/tmp

FLEX_PATH=${BASEDIR}/flex
BISON_PATH=${BASEDIR}/bison
READLINE_PATH=${BASEDIR}/readline
LZ4_PATH=${BASEDIR}/lz4
ZLIB_PATH=${BASEDIR}/zlib
POSTGRES_PATH=${BASEDIR}/postgres

#${LZ4_PATH}/:${ZLIB_PATH}/:${READLINE_PATH}/:${FLEX_PATH}/:${BISON_PATH}/:${POSTGRES_PATH}/
echo "PATH=${LZ4_PATH}/bin:${ZLIB_PATH}/bin:${READLINE_PATH}/bin:${FLEX_PATH}/bin:${BISON_PATH}/bin:${POSTGRES_PATH}/bin:${PATH}"
echo "LD_LIBRARY_PATH=${LZ4_PATH}/lib:${ZLIB_PATH}/lib:${READLINE_PATH}/lib:${FLEX_PATH}/lib:${BISON_PATH}/lib:${POSTGRES_PATH}/lib:${LD_LIBRARY_PATH}"
echo "PKG_CONFIG_PATH=${LZ4_PATH}/lib/pkgconfig:${ZLIB_PATH}/lib/pkgconfig:${READLINE_PATH}/lib/pkgconfig:${FLEX_PATH}/lib/pkgconfig:${BISON_PATH}/lib/pkgconfig:${POSTGRES_PATH}/lib/pkgconfig:${PKG_CONFIG_PATH}"
echo "./configure --prefix=${BASEDIR}/postgresql --with-python --with-lz4 --with-libs=${READLINE_PATH}/lib --with-includes=${READLINE_PATH}/include"
