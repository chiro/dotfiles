#!/bin/bash

set -eu

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

if [[ ! -d "${HOME}"/.asdf ]]; then
    echo "asdf not found. Installing..."
    git clone https://github.com/asdf-vm/asdf.git "${HOME}"/.asdf --branch v0.13.1
    echo "asdf is installed."
fi

if [[ ! -f "${HOME}"/.asdf/shims/ruby ]]; then
    echo "ruby not found. Installing..."
    sudo apt-get install autoconf patch build-essential rustc libssl-dev \
         libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev \
         libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev
    asdf plugin add ruby
    asdf install ruby latest
fi

if [[ ! -f "${HOME}"/.asdf/shims/ghq ]]; then
    echo "ghq not found. Installing..."
    asdf plugin add ghq
    asdf install ghq latest
    asdf global ghq latest
fi

if [[ ! -f "${HOME}"/.asdf/shims/peco ]]; then
    echo "peco not found. Installing..."
    asdf plugin add peco
    asdf install peco latest
    asdf global peco latest
fi

if [[ ! -f "${HOME}"/.asdf/shims/uv ]]; then
    echo "uv not found. Installing..."
    asdf plugin add uv
    asdf install uv latest
    asdf global uv latest
fi

if [[ ! -f "${HOME}"/.asdf/shims/node ]]; then
    echo "nodejs not found. Installing..."
    asdf plugin add nodejs
    asdf install nodejs latest
    asdf global nodejs latest
fi

# Create symlinks
if [[ ! -d "${HOME}"/.emacs.d ]]; then
    ln -sf "${DOTFILES_DIR}"/.emacs.d "${HOME}"/.emacs.d
fi

# bash
ln -sf "${DOTFILES_DIR}"/.bash_aliases "${HOME}"/.bash_aliases
ln -sf "${DOTFILES_DIR}"/.bashrc "${HOME}"/.bashrc

# git
ln -sf "${DOTFILES_DIR}"/.gitconfig "${HOME}"/.gitconfig
ln -sf "${DOTFILES_DIR}"/.gitignore "${HOME}"/.gitignore

ln -sf "${DOTFILES_DIR}"/.gemrc "${HOME}"/.gemrc

# tmux
mkdir -p "${HOME}"/.config/tmux
ln -sf "${DOTFILES_DIR}"/.tmux.conf "${HOME}"/.config/tmux/tmux.conf

# X/XMonad
ln -sf "${DOTFILES_DIR}"/.xprofile "${HOME}"/.xprofile
mkdir -p "${HOME}"/.xmonad
ln -sf "${DOTFILES_DIR}"/.xmonad/xmonad.hs "${HOME}"/.xmonad/xmonad.hs
mkdir -p "${HOME}"/.config/polybar
ln -sf "${DOTFILES_DIR}"/polybar.config.ini "${HOME}"/.config/polybar/config.ini

if [[ ! -f /usr/share/fonts/TTF/SymbolsNerdFontMono-Regular.ttf ]]; then
    echo "Symbols Nerd Font Mono not found. Installing..."
    sudo pacman -S --noconfirm ttf-nerd-fonts-symbols-mono
fi

# Claude Code
mkdir -p "${HOME}"/.claude/agents
ln -sf "${DOTFILES_DIR}"/.claude/CLAUDE.md "${HOME}"/.claude/CLAUDE.md
ln -sf "${DOTFILES_DIR}"/.claude/settings.json "${HOME}"/.claude/settings.json
ln -sf "${DOTFILES_DIR}"/.claude/settings.local.json "${HOME}"/.claude/settings.local.json
ln -sf "${DOTFILES_DIR}"/.claude/agents/code-searcher.md "${HOME}"/.claude/agents/code-searcher.md

# Alacritty
mkdir -p "${HOME}"/.config/alacritty
ln -sf "${DOTFILES_DIR}"/alacritty.toml "${HOME}"/.config/alacritty/alacritty.toml
if [[ ! -d "${HOME}"/.config/alacritty/themes ]]; then
    git clone https://github.com/alacritty/alacritty-theme "${HOME}"/.config/alacritty/themes
fi
