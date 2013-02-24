#!/bin/sh -ex
VERSION=0.0.5
SHPECDIR=${TMPDIR}/shpec-${VERSION}

cd $TMPDIR
curl -sL https://github.com/shpec/shpec/archive/${VERSION}.tar.gz | tar zxf -
cd $SHPECDIR
make install
cd $TMPDIR
rm -rf $SHPECDIR
