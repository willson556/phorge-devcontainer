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

## Debugging

- Go to the debug tab of VSCode.
- Start the `Listen for Xdebug` configuration.
- Set one or more breakpoints.
- Navigate to page that triggers the breakpoint(s).