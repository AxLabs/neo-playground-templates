#!/usr/bin/env bash

# These are the env vars that can be set externally:
# - `DOCKER_IMAGE_URL`
# - `TEMPLATES_JSON_FILE_PATH`
# - `DOCKER_IMAGES_TAGS_FILE_PATH`

BASE_DOCKER_IMAGE_URL=${DOCKER_IMAGE_URL:-"ghcr.io/axlabs/neo-playground/code-server"}
PLAYGROUND_TEMPLATES_JSON_FILE_PATH=${TEMPLATES_JSON_FILE_PATH:-"neo-playground-templates.json"}
BUILT_DOCKER_IMAGES_TAGS_FILE_PATH=${DOCKER_IMAGES_TAGS_FILE_PATH:-"docker-successful-image-tags.tmp"}

command -v jq >/dev/null || { echo "Command 'jq' not found in \$PATH. Please, first install it." >&2; exit 1; }
command -v docker >/dev/null || { echo "Command 'docker' not found in \$PATH. Please, first install it." >&2; exit 1; }

IDENTIFIERS=($(cat neo-playground-templates.json | jq -r '.[] .id'))

# test regex, here: https://www.regextester.com
PATTERN="^([A-z0-9]+)+\.([A-z0-9]+)+\.([A-z0-9]+(-{1})?[A-z0-9]*)*([A-z0-9]+)+$"

for INDEX in "${!IDENTIFIERS[@]}"; do
  ID=${IDENTIFIERS[$INDEX]}
  WORKSPACE_PATH=$(cat ${PLAYGROUND_TEMPLATES_JSON_FILE_PATH} | jq -r --arg i "$INDEX" '.[$i |tonumber] .workspace .path')
  echo ""
  echo "##########################"
  echo "ID=$ID"
  echo "WORKSPACE_PATH=$WORKSPACE_PATH"
  if [[ "$ID" =~ $PATTERN ]]; then
    NEO_IMAGE="${BASH_REMATCH[1]}.${BASH_REMATCH[2]}"
    echo "NEO_IMAGE=${NEO_IMAGE}"

    CUSTOM_CMD=$(cat ${PLAYGROUND_TEMPLATES_JSON_FILE_PATH} | jq -r --arg i "$INDEX" '.[$i |tonumber] .imageBuild .customCmd | select (.!=null)')
    if [ -z ${CUSTOM_CMD+x} ]; then
      echo "CUSTOM_CMD is not set. Skipping...";
    fi
    echo "CUSTOM_CMD=$CUSTOM_CMD"

    TOURS_PATH=$(cat ${PLAYGROUND_TEMPLATES_JSON_FILE_PATH} | jq -r --arg i "$INDEX" '.[$i |tonumber] .codeTour .path | select (.!=null)')
    echo "TOURS_PATH=${TOURS_PATH}"

    WELCOME_PATH=$(cat ${PLAYGROUND_TEMPLATES_JSON_FILE_PATH} | jq -r --arg i "$INDEX" '.[$i |tonumber] .welcome .path | select (.!=null)')
    echo "WELCOME_PATH=${WELCOME_PATH}"

    echo "-------------------------"
    echo "Docker BUILD:"
    echo ""

    DOCKER_IMAGE_TAG="${BASE_DOCKER_IMAGE_URL}/${ID}:latest"
    docker build \
      --build-arg TEMPLATE_ID="${ID}" \
      --build-arg GIT_PATH="${WORKSPACE_PATH}" \
      --build-arg NEO_IMAGE="${NEO_IMAGE}" \
      --build-arg CUSTOM_CMD="${CUSTOM_CMD}" \
      --build-arg TOURS_PATH="${TOURS_PATH}" \
      --build-arg WELCOME_PATH="${WELCOME_PATH}" \
      -t ${DOCKER_IMAGE_TAG} \
      -f ./docker/Dockerfile \
      "./${ID}" || { echo "ERROR: '$ID' failed in the 'docker build' phase. Aborting."; exit 1; }

    echo ${DOCKER_IMAGE_TAG} >> ${BUILT_DOCKER_IMAGES_TAGS_FILE_PATH}

  else
    echo "ERROR: '$ID' does not match with the format. Aborting...";
    exit 1;
  fi
done