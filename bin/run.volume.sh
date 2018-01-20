#!/bin/sh

VERSION=$1

docker run \
--privileged \
-it \
-e NPM_COMMAND=test \
-v `pwd`:/workspace \
redpandaci/npm-command-runner:$VERSION