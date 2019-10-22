#!/usr/bin/env sh

# Install wasienv
curl https://raw.githubusercontent.com/wasienv/wasienv/master/install.sh | sh

# Build jq
JQ_VERSION=1.6
DIRECTORY="jq-${JQ_VERSION}"

if [ ! -d "$DIRECTORY" ]; then
  wget https://github.com/stedolan/jq/releases/download/jq-${JQ_VERSION}/jq-${JQ_VERSION}.tar.gz
  tar xf jq-${JQ_VERSION}.tar.gz
fi

cd ${DIRECTORY}

echo "Configure"

# Configure oniguruma
(
 cd modules/oniguruma
 autoreconf -fi
)

# Configure and compile LLVM bitcode
wasiconfigure ./configure \
  --disable-maintainer-mode \
  --with-oniguruma=builtin || exit $?

# echo "Build"
wasimake make LDFLAGS=-all-static || exit $?
echo "Done"
