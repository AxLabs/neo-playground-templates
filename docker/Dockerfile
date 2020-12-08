ARG NEO_IMAGE
ARG NEO_IMAGE_TAG=latest
FROM ghcr.io/axlabs/neo-playground/code-server/${NEO_IMAGE}:${NEO_IMAGE_TAG}

ARG GIT_PATH
ARG CUSTOM_CMD

RUN chown -R neo:neo /config

USER neo
COPY $GIT_PATH $HOME/workspace
RUN if [ -z ${CUSTOM_CMD+x} ]; then echo "CUSTOM_CMD is not set."; else bash -c "$CUSTOM_CMD"; fi

USER root