# dotfiles

## Description

A configuration driven set of dotfiles that enable you to control which type of packages and
configurations you want to install on your machine.

This is only possible due to the existence of
[dotbot](https://github.com/anishathalye/dotbot), and requires a pre-existing Python installation
on your machine.

## Usage

Start by cloning the repository to your `~/.dotfiles` directory and moving to that newly created
directory:

```bash
git clone https://github.com/michaelheyman/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

There are a few installation options.

### Install Default

Run `./install` to get the default installation on your machine.

This installation directive will attempt to detect the system that you are running, and install
the adequate packages and configurations.

There is probably some work that can be done here to improve this experience.

### Install Profile

There is a list of profiles under [meta/profiles](./meta/profiles/) that can be installed
individually:

- `darwin`: For darwin systems.
- `debian`: For debian systems.
- `devcontainer`: Lightweight devcontainer system.

Install any of these profiles by running `./install-profile <profile-name>`.

## Development

Make modifications and run `make docker-run`. Inside the container, install your dotfiles to verify
effect.
