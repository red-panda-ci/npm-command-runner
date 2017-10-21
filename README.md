# npm-command-runner

_Node image with docker in docker strategy used to execute npm commands._

_Supported tags and respective `Dockerfile` links:_
[`test`, `latest`, `1.0.0`](Dockerfile)

## Use

```bash

docker run \
--privileged \
-e USER=red-panda-ci \
-e REPO=generator-redpanda-node-module \
-e BRANCH=develop \
-e NPM_COMMAND=test \
redpandaci/npm-command-runner:latest

# Use with private token

docker run \
--privileged \
-e TOKEN=some-token \
-e USER=red-panda-ci \
-e REPO=generator-redpanda-node-module \
-e BRANCH=develop \
-e NPM_COMMAND=test \
redpandaci/npm-command-runner:latest

# Run with volume to store coverage 

docker run \
--rm \
--privileged \
-e FORCE_COLOR=1 \
-e USER=$GIT_USER \
-e REPO=$GIT_REPO \
-e BRANCH=$GIT_BRANCH \
-e TOKEN=$GIT_TOKEN \
-e NPM_COMMAND=test \
-e COVERAGE_PATH='coverage' \ # add in /reports all coverage files
-v `pwd`/coverage:/reports \
redpandaci/npm-command-runner:1.0.0

```

## Versions

- node `v8.5.0`
- npm `v5.5.1`
- docker `v17.10.0-ce-rc2`
- docker-compose `v1.16.1`
- git `v2.13.5`

## How to develop?

- run `npm install`
- upgrade Dockerfile
- run `npm test` or `bin/test.sh`
- commit your changes
- publish new image

## Considerations

_This project only uses `npm` to do [commit validations](https://github.com/willsoto/validate-commit) and verify [Dockerfile coding style](https://github.com/redcoolbeans/dockerlint)._++