#!/bin/sh -ex
VERSION=0.0.4
SHPECDIR=${TMPDIR}/shpec-${VERSION}

cd $TMPDIR
curl -sL https://github.com/shpec/shpec/archive/${VERSION}.tar.gz | tar zxf -
cd $SHPECDIR
sudo make install
cd $TMPDIR
rm -rf $SHPECDIR
