#!/bin/sh
set -e

if ! [ -d kakoune ] ; then
    git clone https://github.com/mawww/kakoune.git
else
    cd kakoune ; git pull ; cd -
fi

if ! [ -d ncurses-6.0 ] ; then
    wget http://ftp.gnu.org/gnu/ncurses/ncurses-6.0.tar.gz
    tar xzf ncurses-6.0.tar.gz
fi

docker build --rm --build-arg http_proxy=$http_proxy --build-arg https_proxy=$https_proxy -t kakobuild .
set -x
docker run --rm -t -v $PWD/kakoune:/kakoune -v $PWD/ncurses-6.0:/ncurses -v $PWD/opt:/opt -v /usr/lib:/host/usr/lib kakobuild bash --login -c '
export LIBRARY_PATH=/opt/kakoune/lib:$LIBRARY_PATH
export CPATH=/opt/kakoune/include:/opt/kakoune/include/ncurses:$CPATH
# cd /ncurses ; ./configure --config-cache --enable-widec --prefix=/opt/kakoune ; make -j $(getconf _NPROCESSORS_ONLN) ; make install
export LDFLAGS="-Wl,-rpath=\$\$ORIGIN/../lib"
cd /kakoune/src ; make ; env PREFIX=/opt/kakoune make install
'

