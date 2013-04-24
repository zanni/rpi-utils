#!/bin/bash
# dep apt-get install git gcc-arm-linux-gnueabi make ncurses-dev 
HERE=$(pwd)
BUILD_PATH=$HERE/build

NODE_PATH=node
NODE_URL=git@github.com:joyent/node.git
NODE_VERSION=v0.8.23-release

TOOL_PATH=tools
TOOL_URL=git://github.com/raspberrypi/tools.git

if [ ! -d $BUILD_PATH  ]
then
	mkdir $BUILD_PATH
fi

cd $BUILD_PATH

if [ ! -d $TOOL_PATH  ]
then
	cd $TOOL_PATH
	git clone $TOOL_URL
	cd ..
fi

HOST=$BUILD_PATH/$TOOL_PATH/arm-bcm2708/arm-bcm2708hardfp-linux-gnueabi/bin/arm-bcm2708hardfp-linux-gnueabi
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
export LD="$CXX"

if [ ! -d $NODE_PATH  ]
then
	git clone $NODE_URL
	cd $NODE_PATH
	git checkout -b origin/$NODE_VERSION
	make clean 
	./configure --prefix=/media/fs --without-snapshot --dest-cpu=arm --dest-os=linux 
	make --jobs 8
	make install
else
	cd $NODE_PATH
	# ./configure --prefix=/media/fs --without-snapshot --dest-cpu=arm --dest-os=linux 
	make install 
fi

cd ..

