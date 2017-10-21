#!/bin/sh

VERSION=$1

docker run \
--privileged \
-it \
-e USER=red-panda-ci \
-e REPO=generator-redpanda-node-module \
-e BRANCH=develop \
-e NPM_COMMAND='test' \
redpandaci/npm-command-runner:$VERSION