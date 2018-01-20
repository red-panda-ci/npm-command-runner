#!/bin/sh

VERSION=$1

docker run \
--privileged \
-it \
-e USER=red-panda-ci \
-e REPO=generator-redpanda-node-module \
-e BRANCH=develop \
-e NODE=6 \
-e NPM_COMMAND=test \
-e GENERATED_FILES=coverage \
-v `pwd`/coverage:/generated-files \
redpandaci/npm-command-runner:$VERSION