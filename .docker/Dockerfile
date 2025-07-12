FROM debian:bookworm-slim

RUN apt-get update \
    && apt-get install -y bash curl git sudo ca-certificates --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# install chezmoi
RUN sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin

WORKDIR /app

COPY . .

# ENV CHEZMOI_OS=linux

RUN chezmoi --source /app/home apply -v
