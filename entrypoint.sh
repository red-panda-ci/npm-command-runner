#!/usr/bin/env bash

. ~/.nvm/nvm.sh
. ~/.profile
. ~/.bashrc

set -xe

pull_source_code(){
  local user repo branch token pr_branch pr_branch_id
  user=$1
  repo=$2
  branch=$3
  token=$4

  # For pull requests https://help.github.com/articles/checking-out-pull-requests-locally/
  if [[ $branch == *PR-[0-9]* ]]; then
    pr_branch_id=$(echo $branch | cut -f2 -d "-")
    pr_branch="PR-$pr_branch_id"
    branch=develop
  fi

  if [[ -z $token ]]; then
    git clone -b $branch "https://github.com/$user/$repo.git" .
  else
    git clone -b $branch "https://$token@github.com/$user/$repo.git" .
  fi

  if [[ $pr_branch == *PR-[0-9]* ]]; then
    git fetch origin "pull/$pr_branch_id/head:$pr_branch"
    git checkout $pr_branch
  fi
}

execute_with_node_version(){
  local node_version; node_version=$1

  nvm install $node_version
  nvm use $node_version
}

run_npm_command(){
  local cmd; cmd=$1
  npm run $cmd
}
install_dependencies(){
  npm install
}

copy_to_generated_file_folder(){
  local from to
  from=$1
  to="/generated-files"
  cp -R $from $to
}

main(){

  if [[ -n $NODE ]]; then
    execute_with_node_version $NODE
  fi

  # if not have a repository get code source from a volume: -v `pwd`:/workspace
  if [[ -n $REPO ]]; then
    pull_source_code $USER $REPO $BRANCH $GITHUB_TOKEN
  fi

  # if the node version is not specified, it is executed with the previously installed one in base image
  if [[ -n $NODE ]]; then
    execute_with_node_version $NODE
  fi

  install_dependencies
  run_npm_command $NPM_COMMAND

  if [[ -n $GENERATED_FILES ]]; then
    copy_to_generated_file_folder $GENERATED_FILES
  fi
}

main "$@"