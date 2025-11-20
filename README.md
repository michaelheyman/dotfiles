# dotfiles

My personal dotfiles, managed by [chezmoi](https://chezmoi.io).

## Description

This is a configuration-driven set of dotfiles that allows me to version control my development
environment and keep it consistent across multiple machines. It uses `chezmoi` to manage
configurations for different operating systems (macOS and Linux) and environments.

## Optional

This repository can be installed via HTTPS or SSH. In order to install via SSH, you must set up
[SSH authentication with GitHub](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent).

## Installation

You can install `chezmoi` and initialize your dotfiles from this repository with a single command.
This will also apply the changes to your home directory.

If you prefer to review the changes before applying them, you can omit the `--apply` flag and then
run `chezmoi diff` to see a preview and `chezmoi apply -v` to execute the changes.

### Install via SSH (Recommended)

```bash
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply git@github.com:michaelheyman/dotfiles.git
```

### Install via HTTPS

```bash
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply https://github.com/michaelheyman/dotfiles.git
```

## Development and Testing

To make changes to your dotfiles, you can edit the source files directly and then apply them.

1. **Edit a file**:
    Use `chezmoi edit` to open a file in your editor.

    ```bash
    chezmoi edit ~/.bashrc
    ```

2. **Apply changes**:
    Run `chezmoi apply` to apply any pending changes.

    ```bash
    chezmoi apply -v
    ```

3. **Commit and push changes**:
    The source directory (`~/.local/share/chezmoi`) is a git repository. Commit and push your
    changes as you would with any other repository.

    ```bash
    chezmoi cd
    git add .
    git commit -m "Add new feature"
    git push
    ```

### Testing with Docker

A `Dockerfile` is included in the `.docker/` directory to provide a clean environment for testing
your dotfiles on Linux.

1. **Build the Docker image**:
    From the root of the repository, run:

    ```bash
    task docker:build
    ```

2. **Run the container**:
    The `Dockerfile` is configured to automatically run `chezmoi apply`. You can run the container
    interactively to see the results:

    ```bash
    task docker:run
    ```
