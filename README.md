# Phorge DevelopmentContainer

## Overview

This developer container quickly spins up a VSCode development environment for Phorge enabling:
- Intellisense
- Debugging
- Pre-configured major Phorge features including:
  - Developer mode / dark console
  - Notifications (Aphlict)
  - Repository hosting (SSH + HTTP)

## Basic Usage

- Clone this repository.
- Open the cloned repository folder in VSCode.
- Press `F1` then `Remote-Containers: Reopen in Container`.
- Add `127.0.0.1 phorge.localhost` entry to your HOSTS file.
- Browse to `http://phorge.localhost` in your browser.

## Customizing

You can customize some parts of the `docker-compose.yml` file by creating a `.env` file in `.devcontainer`  

To get started, copy `.devcontainer/.env.sample` and make appropriate edits

You can edit the following

`PHORGE_WEB_PORT` - Defaults to port `80`, set to something else if desired
`PHORGE_SSH_PORT` - The SSH port that phorge repos will be available on.  Defaults to `22280`
`PHORGE_BASE_URI` - The entry should match your hosts file.  Defaults to `http://phorge.localhost` - However, if you update `PHORGE_WEB_PORT` to something other than `80` you will need to update this URI to match.  e.g. if port is `8020` make this URI `http://phorge.localhost:8020`


## Debugging

- Go to the debug tab of VSCode.
- Start the `Listen for Xdebug` configuration.
- Set one or more breakpoints.
- Navigate to page that triggers the breakpoint(s).