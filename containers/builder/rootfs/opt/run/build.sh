#!/bin/sh
#
# Executes the build processes of vmangos, based on the
# build & source directories provided by the environment variables.
#
# All source files are prebaked within the container image.
#
BUILD_THREADS=${BUILD_THREADS:-1}

mkdir -p \
    "$BUILD_DIR"/config \
    "$BUILD_DIR"/storage/data \
    "$BUILD_DIR"/storage/honor \
    "$BUILD_DIR"/storage/logs \
    "$SOURCE_DIR/build"

cd "$SOURCE_DIR/build"

cmake \
    -DCMAKE_INSTALL_PREFIX=$BUILD_DIR ../ \
    -DUSE_PCH=1 \
    -DUSE_STD_MALLOC=0 \
    -DBUILD_FOR_HOST_CPU=0 \
    -DTBB_DEBUG=0 \
    -DUSE_SCRIPTS=1 \
    -DUSE_EXTRACTORS=1 \
    -DUSE_REALMMERGE=0 \
    -DENABLE_MAILSENDER=1 \
    -DDEBUG_SYMBOLS=0 \
    $@

make -j "$BUILD_THREADS"
make install

chmod +x "$BUILD_DIR"/bin/*
find "$BUILD_DIR"/bin/Extractors/ -type f ! -regex ".*\.\(json\|txt\)$" -exec chmod +x {} +

# Patch to handle issues with CPU Concurrency
# sed -i 's/os.cpu_count()/1/g' "$BUILD_DIR/bin/Extractors/mmap_extract.py"