#!/usr/bin/env sh

cd jq-1.6

# # Clean previous compilation files
# ./configure
# make distclean

# Configure oniguruma
(
  cd modules/oniguruma
  autoreconf -vfi
)

# Configure and compile LLVM bitcode
emconfigure ./configure \
  --disable-maintainer-mode \
  --host=wasm32-unknown-emscripten \
  --with-oniguruma=builtin || exit $?
emmake make || exit $?

# Generate `.wasm` file
mv jq jq.bc
emcc jq.bc -o jq.wasm
