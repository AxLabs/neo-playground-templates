#!/usr/bin/env bash

BASE_DOCKER_IMAGE_URL="ghcr.io/axlabs/neo-playground/code-server"

command -v jq >/dev/null || { echo "Command 'jq' not found in \$PATH. Please, first install it." >&2; exit 1; }
command -v docker >/dev/null || { echo "Command 'docker' not found in \$PATH. Please, first install it." >&2; exit 1; }

IDENTIFIERS=($(cat neo-playground-templates.json | jq -r '.[] .id'))

# test regex, here: https://www.regextester.com
PATTERN="^([A-z0-9]+)+\.([A-z0-9]+)+\.([A-z0-9]+(-{1})?[A-z0-9]*)*([A-z0-9]+)+$"

for INDEX in "${!IDENTIFIERS[@]}"; do
  ID=${IDENTIFIERS[$INDEX]}
  WORKSPACE_PATH=$(cat neo-playground-templates.json | jq -r --arg i "$INDEX" '.[$i |tonumber] .workspace .path')
  echo "ID=$ID"
  echo "WORKSPACE_PATH=$WORKSPACE_PATH"
  if [[ "$ID" =~ $PATTERN ]]; then
    NEO_IMAGE="${BASH_REMATCH[1]}.${BASH_REMATCH[2]}"
    echo "NEO_IMAGE=${NEO_IMAGE}"

    CUSTOM_CMD=$(cat neo-playground-templates.json | jq -r --arg i "$INDEX" '.[$i |tonumber] .imageBuild .customCmd | select (.!=null)')
    if [ -z ${CUSTOM_CMD+x} ]; then
      echo "CUSTOM_CMD is not set. Skipping...";
    fi
    echo "CUSTOM_CMD=$CUSTOM_CMD"

    docker build \
      --build-arg GIT_PATH="${WORKSPACE_PATH}" \
      --build-arg NEO_IMAGE="${NEO_IMAGE}" \
      --build-arg CUSTOM_CMD="${CUSTOM_CMD}" \
      -t ${BASE_DOCKER_IMAGE_URL}/${ID}:latest \
      -f ./docker/Dockerfile \
      "./${ID}" || { echo "ERROR: '$ID' failed in the 'docker build' phase. Aborting."; exit 1; }

    docker push ${BASE_DOCKER_IMAGE_URL}/${ID}:latest || { echo "ERROR: '$ID' failed in the 'docker push' phase. Aborting."; exit 1; }
  else
    echo "ERROR: '$ID' does not match with the format. Aborting...";
    exit 1;
  fi
done