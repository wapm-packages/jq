#!/usr/bin/env sh

cd jq-1.6

# Clean previous compilation files
echo "Clean"
./configure
make distclean

echo "Configure"

# Configure oniguruma
#(
#  cd modules/oniguruma
  autoreconf -fi
#)

# Configure and compile LLVM bitcode
emconfigure ./configure \
  --disable-maintainer-mode \
  --with-oniguruma=builtin || exit $?

echo "Build"
emmake make LDFLAGS=-all-static || exit $?

# Generate `.wasm` file
echo "Link"
mv jq jq.o
emcc jq.o -o ../jq.wasm -s ERROR_ON_UNDEFINED_SYMBOLS=0

echo "Done"
