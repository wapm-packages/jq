#!/usr/bin/env sh

JQ_VERSION=1.6

wget https://github.com/stedolan/jq/releases/download/jq-${JQ_VERSION}/jq-${JQ_VERSION}.tar.gz
tar xf jq-${JQ_VERSION}.tar.gz
cd jq-${JQ_VERSION}

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

echo "Clean"
cd ..
rm -rf jq-${JQ_VERSION} jq-${JQ_VERSION}.tar.gz

echo "Done"
