# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles repository. Config files are symlinked from this repo to `$HOME` via `install.sh`.

## Setup

```bash
./install.sh
```

This script installs tools via asdf (ruby, ghq, peco, uv, nodejs), the Nerd Font used by polybar's icons, and creates symlinks for all config files.

## Key Components

- **Emacs**: `.emacs.d/init.el` bootstraps package management (use-package + MELPA) and loads config modules from `.emacs.d/inits/` via init-loader. Files in `inits/` are loaded in lexicographic order (prefix numbers control load order).
- **Shell**: `.bashrc` and `.bash_aliases`
- **Window Manager**: XMonad (`.xmonad/xmonad.hs`) with Polybar (`polybar.config.ini`)
- **Terminal**: Alacritty (`alacritty.toml`)
- **Git**: `.gitconfig`, `.gitignore`
- **Tmux**: `.tmux.conf`
- **Claude Code**: `.claude/` (settings, agents)

## Conventions

- When adding a new Emacs config module, place it in `.emacs.d/inits/` with an appropriate numeric prefix matching the existing scheme (00-09: core, 10-19: navigation/completion, 20-39: language/mode support, 90+: UI/utilities).
- Symlinks are created in `install.sh` — when adding a new dotfile, add the corresponding `ln -sf` command there.
