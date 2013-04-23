#!/bin/bash
cd ../modules/node

if [ -z "$HOST" ]; then
  HOST=$PREFIX
fi
export CPP="${HOST}-gcc -E"
export STRIP="${HOST}-strip"
export OBJCOPY="${HOST}-objcopy"
export AR="${HOST}-ar"
export RANLIB="${HOST}-ranlib"
export LD="${HOST}-ld"
export OBJDUMP="${HOST}-objdump"
export CC="${HOST}-gcc"
export CXX="${HOST}-g++"
export NM="${HOST}-nm"
export AS="${HOST}-as"
export PS1="[${HOST}] \w$ "

#export GYP_DEFINES="armv7=0"
#export CCFLAGS='-march=armv6 -mfloat-abi=hard -DUSE_EABI_HARDFLOAT'
#export CXXFLAGS='-march=armv6 -mfloat-abi=hard -DUSE_EABI_HARDFLOAT'

export LD="$CXX"
./configure --prefix=/media/fs --without-snapshot --dest-cpu=arm --dest-os=linux 


#./configure --without-snapshot --dest-cpu=arm --dest-os=linux 
make clean 
make --jobs 8 
make install

