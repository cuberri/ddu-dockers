#!/bin/sh

set -u
set -e


ROK4_VERSION=${1}
ROK4_SRC_DIR=/tmp/rok4-src
ROK4_BUILD_DIR=${ROK4_SRC_DIR}/build
ROK4_INSTALL_DIR=/usr/local/rok4

echo "Building ROK4 ${ROK4_VERSION}"

# Preparing the source build
cd /tmp
curl "http://www.rok4.org/data/rok4-${ROK4_VERSION}.tar.bz2" | tar xjf -
ROK4_SRC_UNCOMPRESSED_DIRNAME=$(basename $(cd /tmp/;find . -maxdepth 1 -type d -name "rok4*"))
mv /tmp/${ROK4_SRC_UNCOMPRESSED_DIRNAME} ${ROK4_SRC_DIR}
mkdir -p ${ROK4_BUILD_DIR}

# Build ROK4 only
cd ${ROK4_BUILD_DIR}
cmake .. -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX=${ROK4_INSTALL_DIR} -DCMAKE_BUILD_TYPE=Release -DBUILD_ROK4=TRUE -DBUILD_BE4=FALSE -DBUILD_DOC=FALSE -DUNITTEST=FALSE -DDEBUG_BUILD=FALSE  
# Commented out while multi threading the build will cause some errors (no concurency handling ?)
#make -j$(grep ^processor /proc/cpuinfo  | wc -l)
make
make install

