# npm-command-runner

_Node image with docker in docker strategy used to execute npm commands._

* Allows select which node version to run
* Allows obtain files generated by the command
* Get source code from Github
* Get source code from volume
* If use volume to get source code, cache the dependencies of previous executions
* Allows to publish modules in npm

_Supported tags and respective `Dockerfile` links:_
[`test`, `latest`, `1.0.0`, `1.2.0`, `1.3.0`](Dockerfile)
## Use

Use with github repo:

```bash

docker run \
--privileged \
-e USER="<GITHUB_USER>" \
-e REPO="<GITHUB_REPO>" \
-e BRANCH="<BRANCH>" \
-e GITHUB_TOKEN="<CHANGE>" \ # optional
-e NODE="<NODE_VERSION>" \ # IF YOU WANT TO SPECIFY THE NODE VERSION, IF YOU DO NOT SPECIFY US BY DEFAULT 8 stable
-e NPM_COMMAND=test \
redpandaci/npm-command-runner:latest

```
Use getting the files generated by the command:

```bash

docker run \
--privileged \
-e USER="<GITHUB_USER>" \
-e REPO="<GITHUB_REPO>" \
-e BRANCH="<BRANCH>" \
-e NPM_COMMAND=test \
-e GENERATED_FILES=coverage \ # path to the files generated by the command
-v `pwd`/coverage:/generated-files \ # inside the container copies the generated files to path /generated-files
redpandaci/npm-command-runner:latest

```

Use getting the source code from a volume:

```bash

docker run \
--privileged \
-e NPM_COMMAND=test \
-v `pwd`:/workspace \
redpandaci/npm-command-runner:latest

```

Use publishing a node module

```bash

docker run \
--privileged \
-e NPM_COMMAND=publish \
-e NPM_TOKEN=234546754trgfde345 \
-e VERSION=2.0.0 \
-v `pwd`:/workspace \
redpandaci/npm-command-runner:latest

```

## Versions

- nvm `0.33.8`
- default node `v8.9.4`
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

_This project only uses `npm` to do [commit validations](https://github.com/willsoto/validate-commit) and verify [Dockerfile coding style](https://github.com/redcoolbeans/dockerlint)._