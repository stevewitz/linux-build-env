#!/bin/bash

#Generate images for use with external libraries

docker build -t xenial:x86_64 -f Dockerfile.xenial-x86_64-gcc5 .
docker build -t xenial:arm64 -f Dockerfile.xenial-arm64-gcc5 .
docker build -t xenial:android64 -f Dockerfile.xenial-android64 .
docker build -t xenial:android32 -f Dockerfile.xenial-android32 .
