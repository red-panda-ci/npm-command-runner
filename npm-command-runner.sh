#!/usr/bin/env bash

set -xe

: "${USER?Need a Git username}"
: "${REPO?Need a repository name}"
: "${BRANCH?Need a Git branch}"
: "${NPM_COMMAND?Need a npm command}"

sh /usr/local/bin/dockerd-entrypoint.sh & sleep 5 # Launch docker daemon

# For pull requests https://help.github.com/articles/checking-out-pull-requests-locally/
if [[ $BRANCH == *PR-[0-9]* ]]; then
  PR_BRANCH_ID=$(echo $BRANCH | cut -f2 -d "-")
  PR_BRANCH="PR-$PR_BRANCH_ID"
  BRANCH=develop
fi

if [[ -z "${TOKEN}" ]]; then
  git clone -b "$BRANCH" https://github.com/"$USER"/"$REPO".git .
else
  git clone -b "$BRANCH" https://"$TOKEN"@github.com/"$USER"/"$REPO".git .
fi


if [[ $PR_BRANCH == *PR-[0-9]* ]]; then
  git fetch origin pull/$PR_BRANCH_ID/head:$PR_BRANCH
  git checkout $PR_BRANCH
fi


npm install

npm $NPM_COMMAND

if [ -n "$COVERAGE_PATH" ]; then
  cp -R $COVERAGE_PATH /reports
fi
