FROM alpine:3.18

LABEL maintainer="Luca Gatty"
LABEL description="Alpine Linux with Python 3 and pip"
ENV PYTHONUNBUFFERED=1
ARG GITHUB_ACTOR="bot"
ARG UID=1010
ENV USERNAME="${GITHUB_ACTOR}"
ENV GID="${UID}"
ENV GROUPNAME="${USERNAME}"

WORKDIR /app

# Install dependencies
RUN apk add --no-cache \
    shadow \
    bash \
    curl \
    git \
    python3 \
    py3-pip \
    py3-yaml \
    && addgroup -g "${GID}" "${GROUPNAME}" \
    && adduser -D -u "${UID}" -G "${GROUPNAME}" "${USERNAME}" \
    && usermod -aG wheel "${USERNAME}" \
    && pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir pyyaml

SHELL ["/bin/bash", "-c"]

COPY --chown="${UID}:${GID}" . /app

ENTRYPOINT ["/bin/bash", "-c", "chmod +x /app/entrypoint.sh && /app/entrypoint.sh"]
