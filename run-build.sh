#!/bin/sh

docker run --rm -v .:/code \
  registry.gitlab.com/committed-consulting/mde-devops/epsilon-ci-container:latest \
  /code/build.xml main
