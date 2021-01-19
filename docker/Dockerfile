ARG NEO_IMAGE=base-image
ARG NEO_IMAGE_TAG=latest
FROM ubuntu:focal as builder

ARG GIT_PATH
ARG TOURS_PATH
ARG WELCOME_PATH

COPY . /root
RUN mkdir -p /workspace && \
    bash -c "shopt -s dotglob && cp -R /root/${GIT_PATH}/* /workspace" && \
    if [ -z ${TOURS_PATH+x} ]; then \
        echo "TOURS_PATH is not set."; \
    else \
        if [ -d "/root/${TOURS_PATH}" ]; then \
            bash -c "shopt -s dotglob && cp -R /root/${TOURS_PATH} /workspace"; \
        fi \
    fi;

RUN mkdir -p /welcome && \
    if [ -z ${WELCOME_PATH+x} ]; then \
        echo "WELCOME_PATH is not set."; \
    else \
        if [ -d "/root/${WELCOME_PATH}" ]; then \
            bash -c "shopt -s dotglob && cp -R /root/${WELCOME_PATH}/* /welcome"; \
        fi \
    fi;

FROM ghcr.io/axlabs/neo-playground/code-server/${NEO_IMAGE}:${NEO_IMAGE_TAG}

ARG TEMPLATE_ID
ARG CUSTOM_CMD

ENV TEMPLATE_ID=${TEMPLATE_ID}

USER ${USER_UID}:${USER_GID}

COPY --chown=${USER_UID}:${USER_GID} --from=builder /workspace ${HOME}/workspace
COPY --chown=${USER_UID}:${USER_GID} --from=builder /welcome ${HOME}/extensions/axlabs-team.neo-playground-0.0.1/assets

RUN if [ -z ${CUSTOM_CMD+x} ]; then echo "CUSTOM_CMD is not set."; else bash -c "${CUSTOM_CMD}"; fi

USER root