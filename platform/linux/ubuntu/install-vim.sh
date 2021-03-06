#!/usr/bin/env sh

LUA_PACKAGE_NAME=lua5.2

check () {
if test $? -ne 0; then
	echo "$@"
	exit $?
fi
}

## Install the various dependencies
sudo apt-get install -y -q \
	libncurses5-dev \
	libgnome2-dev \
	libgnomeui-dev \
	libgtk2.0-dev \
	libatk1.0-dev \
	libbonoboui2-dev \
	libcairo2-dev \
	libx11-dev \
	libxpm-dev \
	libxt-dev \
	python-dev \
	ruby-dev \
	mercurial \
	ruby

## Download the sources
echo "Downloading Vim sources..."
mkdir -p ~/.vim/sources
cd ~/.vim/sources
git clone https://github.com/vim/vim
cd vim

# Install lua, and create symlinks so Vim can find it
sudo apt-get install -y -q \
	${LUA_PACKAGE_NAME} \
	lib${LUA_PACKAGE_NAME}-dev

# Symlinks headers, libraries to /usr/local
sudo ln -fvs /usr/include/${LUA_PACKAGE_NAME}/*.h /usr/local/include/
sudo ln -fvs /usr/lib/x86_64-linux-gnu/liblua* /usr/local/lib/
sudo ln -fvs /usr/local/lib/lib${LUA_PACKAGE_NAME}.so /usr/local/lib/liblua.so
sudo ln -fvs /usr/local/lib/lib${LUA_PACKAGE_NAME}.a /usr/local/lib/liblua.a

echo "Configuring Vim..."
make distclean
make clean

./configure \
	--with-features=huge \
	--enable-fail-if-missing \
	--enable-multibyte \
	--enable-largefile \
	--enable-luainterp \
	--with-lua \
	--with-lua-prefix=/usr/local \
	--enable-rubyinterp \
	--enable-pythoninterp \
	--with-python-config-dir=/usr/lib/python2.7/config \
	--enable-gui=gtk2 \
	--enable-cscope \
	--prefix=/usr/local

check "Configure FAILED!"

echo "Making Vim..."
make VIMRUNTIMEDIR=/usr/share/vim/vim74
check "make FAILED!"

echo "Installing Vim..."
sudo make install
check "install FAILED!"

echo "Updating alternatives..."
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
sudo update-alternatives --set editor /usr/bin/vim

sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
sudo update-alternatives --set vi /usr/bin/vim

echo "Done!"

