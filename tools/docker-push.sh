#!/usr/bin/env bash

BUILT_DOCKER_IMAGES_TAGS_FILE_PATH=${DOCKER_IMAGES_TAGS_FILE_PATH:-"docker-successful-image-tags.tmp"}

command -v jq >/dev/null || {
  echo "Command 'jq' not found in \$PATH. Please, first install it." >&2
  exit 1
}
command -v docker >/dev/null || {
  echo "Command 'docker' not found in \$PATH. Please, first install it." >&2
  exit 1
}

if [ ! -f ${BUILT_DOCKER_IMAGES_TAGS_FILE_PATH} ]; then
  echo "File not found: ${BUILT_DOCKER_IMAGES_TAGS_FILE_PATH}"
  exit 1
fi

ERROR=0

while IFS="" read -r IMAGE || [ -n "$IMAGE" ]; do
  echo "-------------------------"
  echo "Docker PUSH:"
  echo "${IMAGE}"
  echo "-------------------------"
  docker push ${IMAGE} || { echo "ERROR: '${IMAGE}' failed in the 'docker push' phase."; ERROR=1; }
done <${BUILT_DOCKER_IMAGES_TAGS_FILE_PATH}

exit ${ERROR}