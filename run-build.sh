#!/bin/bash

set -e

DOCKER_IMAGE=registry.gitlab.com/committed-consulting/mde-devops/epsilon-ci-container:latest

docker pull "$DOCKER_IMAGE"
docker run --rm -v .:/code "$DOCKER_IMAGE" /code/build.xml main

pushd gradle
./gradlew build
popd
