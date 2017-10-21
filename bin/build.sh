#!/bin/bash

VERSION=$1

docker build -t redpandaci/npm-command-runner:$VERSION .