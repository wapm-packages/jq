#!/usr/bin/env sh

cd jq-1.6

# Clean previous compilation files
./configure
make distclean

# Configure oniguruma
#(
#  cd modules/oniguruma
  autoreconf -fi
#)

# Configure and compile LLVM bitcode
emconfigure ./configure \
  --disable-maintainer-mode \
  --with-oniguruma=builtin || exit $?
emmake make LDFLAGS=-all-static || exit $?

# Generate `.wasm` file
mv jq jq.o
emcc jq.o -o ../jq.wasm -s ERROR_ON_UNDEFINED_SYMBOLS=0
