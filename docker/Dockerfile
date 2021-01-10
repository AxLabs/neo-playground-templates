ARG NEO_IMAGE=base-image
ARG NEO_IMAGE_TAG=latest
FROM ghcr.io/axlabs/neo-playground/code-server/${NEO_IMAGE}:${NEO_IMAGE_TAG}

ARG GIT_PATH
ARG CUSTOM_CMD

USER $USER_UID:$USER_GID
COPY $GIT_PATH $HOME/workspace
RUN if [ -z ${CUSTOM_CMD+x} ]; then echo "CUSTOM_CMD is not set."; else bash -c "$CUSTOM_CMD"; fi

USER root