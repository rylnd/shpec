#!/bin/sh
VERSION=0.0.2
cd /tmp
curl -sL https://github.com/shpec/shpec/archive/${VERSION}.tar.gz | tar zxf -
cd shpec-${VERSION}
make install
