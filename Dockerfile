FROM python:3.10-slim-bookworm

RUN apt update \
    # git is required to install submodules
    && apt install -y git \
    # && apt install -y procps \
    # && apt install -y curl \
    # sudo is required to install debian packages
    && apt install -y sudo

WORKDIR /app

COPY . .

# Change default shell to bash which supports source
RUN ln -sf /bin/bash /bin/sh
