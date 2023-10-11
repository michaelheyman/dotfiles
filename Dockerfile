FROM python:3.10-slim-bookworm

RUN apt update \
    && apt install -y git \
    && apt install -y procps \
    && apt install -y curl

WORKDIR /app

COPY . .
