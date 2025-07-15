FROM debian:bookworm-slim

RUN apt-get update \
    && apt-get install -y bash curl git sudo ca-certificates --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

RUN sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin

WORKDIR /app

COPY . .

ENV CHEZMOI_OS=linux

RUN mkdir -p /root/.config/chezmoi && \
    echo '[data]' > /root/.config/chezmoi/chezmoi.toml && \
    echo 'profile = "standard"' >> /root/.config/chezmoi/chezmoi.toml

RUN chezmoi --source /app/home apply -v
