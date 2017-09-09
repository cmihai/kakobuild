#!/bin/sh
if ! [ -d kakoune ] ; then
    git clone https://github.com/mawww/kakoune.git
else
    cd kakoune ; git pull ; cd -
fi
docker build --rm -t kakobuild .
docker run --rm -t -v $PWD/kakoune:/kakoune -v $PWD/opt:/opt kakobuild bash --login -c "cd /kakoune/src ; make ; env PREFIX=/opt/kakoune make install"

