#!/bin/bash

set -e

docker run --rm -v .:/code \
  registry.gitlab.com/committed-consulting/mde-devops/epsilon-ci-container:latest \
  /code/build.xml main

pushd gradle
./gradlew build
popd
