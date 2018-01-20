#!/bin/sh

VERSION=test

docker run \
-it \
--rm \
--privileged \
-e USER=madoos \
-e REPO=type \
-e BRANCH=develop \
-e NODE=6 \
-e NPM_COMMAND=test \
redpandaci/npm-command-runner:$VERSION