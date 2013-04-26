#!/bin/bash
# dep apt-get install git gcc-arm-linux-gnueabi make ncurses-dev 
HERE=$(pwd)
BUILD_PATH=$HERE/build

NODE_PATH=node
NODE_URL=git@github.com:joyent/node.git
NODE_VERSION=v0.10.5-release #v0.8.23-release

TOOL_PATH=tools
TOOL_URL=git://github.com/raspberrypi/tools.git

NPM_PATH=/media/fs/bin/npm

function fixNpm {
	#remove script #! node (fill with prefix)
	sed -i '1d' $NPM_PATH
	#replace with true file node path
	#awk 'NR==1{print "#!/bin/node"}1' $NPM_PATH >> $NPM_PATH 
	sed '1i\
	#!/bin/node' $NPM_PATH > $NPM_PATH
}

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

HOST=$BUILD_PATH/$TOOL_PATH/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin/arm-linux-gnueabihf
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
	if [[ ! $? -ne 0 ]]
	then
		cd $NODE_PATH
		git checkout -b origin/$NODE_VERSION
		make clean 
		./configure --prefix=/media/fs --without-snapshot --dest-cpu=arm --dest-os=linux 
		make --jobs 8 --prefix /media/fs
		make install

		fixNpm

	fi
else
	cd $NODE_PATH
	# ./configure --prefix=/media/fs --without-snapshot --dest-cpu=arm --dest-os=linux 
	make install 

	fixNpm
fi

cd ..

