#!/bin/sh

INSTALL_DIR=/opt/local/Libraries

AUTOWIRING_VERSION=1.0.2
LEAPSERIAL_VERSION=0.4.0
LEAPRESOURCE_VERSION=0.1.0
LEAPHTTP_VERSION=0.1.0
LEAPIPC_VERSION=0.1.0

# Autowiring
echo -n "Autowiring ${AUTOWIRING_VERSION}... "
if [ ! -d ${INSTALL_DIR}/autowiring-${AUTOWIRING_VERSION} ]; then
  echo "BUILDING"
  AUTOWIRING_CHANGED=true
  if [ ! -d autowiring ]; then
    git clone https://github.com/leapmotion/autowiring.git
    cd autowiring
  else
    cd autowiring
    git fetch
  fi
  git checkout v${AUTOWIRING_VERSION}
  if [ -d standard ]; then
    TOOLCHAIN=$(pwd)/standard/toolchain-${ARCH}.cmake
  else
    TOOLCHAIN=$(pwd)/toolchain-${ARCH}.cmake
  fi
  rm -fr build-v${AUTOWIRING_VERSION}
  mkdir -p build-v${AUTOWIRING_VERSION}
  cd build-v${AUTOWIRING_VERSION}
  cmake -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN} \
        -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR}/autowiring-${AUTOWIRING_VERSION} \
        -DCMAKE_BUILD_TYPE=Release \
        .. && make -j 4 && ./bin/AutowiringTest && sudo make install
  cd ../..
else
  echo "(already installed)"
fi

# LeapSerial
echo -n "LeapSerial ${LEAPSERIAL_VERSION}... "
if [ ! -d ${INSTALL_DIR}/leapserial-${LEAPSERIAL_VERSION} ]; then
  LEAPSERIAL_CHANGED=true
  echo "BUILDING"
  if [ ! -d leapserial ]; then
    git clone https://github.com/leapmotion/leapserial.git
    cd leapserial
  else
    cd leapserial
    git fetch
  fi
  git checkout v${LEAPSERIAL_VERSION}
  if [ -d standard ]; then
    TOOLCHAIN=$(pwd)/standard/toolchain-${ARCH}.cmake
  else
    TOOLCHAIN=$(pwd)/toolchain-${ARCH}.cmake
  fi
  rm -fr build-v${LEAPSERIAL_VERSION}
  mkdir -p build-v${LEAPSERIAL_VERSION}
  cd build-v${LEAPSERIAL_VERSION}
  cmake -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN} \
        -DFlatBuffers_FLATC=/opt/local/Libraries-x64/flatbuffers/bin/flatc \
        -DFlatBuffers_HOST_DIR=/opt/local/Libraries-x64/flatbuffers \
        -DFlatBuffers_ROOT_DIR=/opt/local/Libraries-x64/flatbuffers \
        -DProtobuf_HOST_DIR=/opt/local/Libraries-x64/protobuf-3.0.0.2 \
        -DProtobuf_ROOT_DIR=${INSTALL_DIR}/protobuf-3.0.0.2 \
        -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR}/leapserial-${LEAPSERIAL_VERSION} \
        -DCMAKE_BUILD_TYPE=Release \
        .. && make -j 4 && ./bin/LeapSerialTest && sudo make install
  cd ../..
else
  echo "(already installed)"
fi

# LeapResource
echo -n "LeapResource ${LEAPRESOURCE_VERSION}... "
if [ ! -d ${INSTALL_DIR}/leapresource-${LEAPRESOURCE_VERSION} ] || [ ! -z $AUTOWIRING_CHANGED ] || [ ! -z $LEAPSERIAL_CHANGED ]; then
  echo "BUILDING"
  if [ ! -d LeapResource ]; then
    git clone git@github.com:leapmotion/LeapResource.git
    cd LeapResource
  else
    cd LeapResource
    git fetch
  fi
  git checkout v${LEAPRESOURCE_VERSION}
  if [ -d standard ]; then
    TOOLCHAIN=$(pwd)/standard/toolchain-${ARCH}.cmake
  else
    TOOLCHAIN=$(pwd)/toolchain-${ARCH}.cmake
  fi
  rm -fr build-v${LEAPRESOURCE_VERSION}
  mkdir -p build-v${LEAPRESOURCE_VERSION}
  cd build-v${LEAPRESOURCE_VERSION}
  cmake -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN} \
        -DBOOST_ROOT=${INSTALL_DIR}/boost_1_55_0 \
        -DAutowiring_DIR=${INSTALL_DIR}/autowiring-${AUTOWIRING_VERSION} \
        -DLeapSerial_DIR=${INSTALL_DIR}/leapserial-${LEAPSERIAL_VERSION} \
        -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR}/leapresource-${LEAPRESOURCE_VERSION} \
        -DCMAKE_BUILD_TYPE=Release \
        .. && make -j 4 && ./bin/LeapResourceTest && sudo make install
  cd ../..
else
  echo "(already installed)"
fi

# LeapHTTP
echo -n "LeapHTTP ${LEAPHTTP_VERSION}... "
if [ ! -d ${INSTALL_DIR}/leaphttp-${LEAPHTTP_VERSION} ] || [ ! -z $AUTOWIRING_CHANGED ]; then
  echo "BUILDING"
  if [ ! -d LeapHTTP ]; then
    git clone git@github.com:leapmotion/LeapHTTP.git
    cd LeapHTTP
  else
    cd LeapHTTP
    git fetch
  fi
  git checkout v${LEAPHTTP_VERSION}
  if [ -d standard ]; then
    TOOLCHAIN=$(pwd)/standard/toolchain-${ARCH}.cmake
  else
    TOOLCHAIN=$(pwd)/toolchain-${ARCH}.cmake
  fi
  rm -fr build-v${LEAPHTTP_VERSION}
  mkdir -p build-v${LEAPHTTP_VERSION}
  cd build-v${LEAPHTTP_VERSION}
  cmake -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN} \
        -DOPENSSL_INCLUDE_DIR=${INSTALL_DIR}/openssl/include \
        -DOPENSSL_CRYPTO_LIBRARY=${INSTALL_DIR}/openssl/lib/libcrypto.a \
        -DOPENSSL_SSL_LIBRARY=${INSTALL_DIR}/openssl/lib/libssl.a \
        -DCURL_ROOT_DIR=${INSTALL_DIR}/curl-7.36.0 \
        -DZLIB_ROOT_DIR=${INSTALL_DIR}/zlib-1.2.8 \
        -Dautowiring_DIR=${INSTALL_DIR}/autowiring-${AUTOWIRING_VERSION} \
        -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR}/leaphttp-${LEAPHTTP_VERSION} \
        -DCMAKE_BUILD_TYPE=Release \
        .. && make -j 4 && ./bin/LeapHTTPTest && sudo make install
  cd ../..
else
  echo "(already installed)"
fi

# LeapIPC
echo -n "LeapIPC ${LEAPIPC_VERSION}... "
if [ ! -d ${INSTALL_DIR}/leapipc-${LEAPIPC_VERSION} ] || [ ! -z $AUTOWIRING_CHANGED ] || [ ! -z $LEAPSERIAL_CHANGED ]; then
  echo "BUILDING"
  if [ ! -d LeapIPC ]; then
    git clone https://github.com/leapmotion/LeapIPC.git
    cd LeapIPC
  else
    cd LeapIPC
    git fetch
  fi
  git checkout v${LEAPIPC_VERSION}
  if [ -d standard ]; then
    TOOLCHAIN=$(pwd)/standard/toolchain-${ARCH}.cmake
  else
    TOOLCHAIN=$(pwd)/toolchain-${ARCH}.cmake
  fi
  rm -fr build-v${LEAPIPC_VERSION}
  mkdir -p build-v${LEAPIPC_VERSION}
  cd build-v${LEAPIPC_VERSION}
  cmake -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN} \
        -Dautowiring_DIR=${INSTALL_DIR}/autowiring-${AUTOWIRING_VERSION} \
        -Dleapserial_DIR=${INSTALL_DIR}/leapserial-${LEAPSERIAL_VERSION} \
        -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR}/leapipc-${LEAPIPC_VERSION} \
        -DCMAKE_BUILD_TYPE=Release \
        .. && make -j 4 && ./bin/LeapIPCTest && sudo make install
  cd ../..
else
  echo "(already installed)"
fi
