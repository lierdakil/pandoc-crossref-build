#!/bin/bash
if [ -n "$DOCKER_USERNAME" ]; then
  echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
fi
docker push lierdakil/pandoc-crossref-build:latest
