FROM alpine:3.18

LABEL maintainer="Luca Gatty"
LABEL description="Alpine Linux with Python 3 and pip"
ENV PYTHONUNBUFFERED=1
ENV UID=1010
ENV USERNAME=appuser
ENV GID=1010
ENV GROUPNAME=appuser

WORKDIR /app

# Install dependencies
RUN apk update && \
    apk add --no-cache \
    bash \
    curl \
    git \
    python3 \
    py3-pip \
    && pip install --no-cache-dir pyyaml

SHELL ["/bin/bash", "-c"]

RUN addgroup -g "${GID}" "${GROUPNAME}}" && \
    adduser -D -u "${UID}" -G "${GROUPNAME}}" "${USERNAME}"

COPY --chown="${UID}:${GID}" . /app

ENTRYPOINT ["/bin/bash", "-c", "/app/entrypoint.sh"]
