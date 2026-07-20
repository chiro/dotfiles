#!/bin/bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

if command -v pacman >/dev/null 2>&1; then
    PACKAGE_MANAGER="pacman"
elif command -v apt-get >/dev/null 2>&1; then
    PACKAGE_MANAGER="apt"
else
    echo "Unsupported distribution: pacman or apt-get is required." >&2
    exit 1
fi

install_packages() {
    case "${PACKAGE_MANAGER}" in
        pacman)
            sudo pacman -S --needed --noconfirm "$@"
            ;;
        apt)
            sudo apt-get install -y "$@"
            ;;
    esac
}

if [[ ! -d "${HOME}"/.asdf ]]; then
    echo "asdf not found. Installing..."
    git clone https://github.com/asdf-vm/asdf.git "${HOME}"/.asdf --branch v0.13.1
    echo "asdf is installed."
fi

if [[ ! -f "${HOME}"/.asdf/shims/ruby ]]; then
    echo "ruby not found. Installing..."
    case "${PACKAGE_MANAGER}" in
        pacman)
            install_packages base-devel rust openssl libyaml readline zlib gmp ncurses \
                libffi gdbm libdb
            ;;
        apt)
            install_packages autoconf patch build-essential rustc libssl-dev \
                libyaml-dev libreadline-dev zlib1g-dev libgmp-dev libncurses-dev \
                libffi-dev libgdbm-dev libdb-dev uuid-dev
            ;;
    esac
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
ln -sf "${DOTFILES_DIR}"/polybar.launch.sh "${HOME}"/.config/polybar/launch.sh

if ! fc-list : family 2>/dev/null | grep -Fq "Symbols Nerd Font Mono"; then
    echo "Symbols Nerd Font Mono not found. Installing..."
    install_packages curl fontconfig
    mkdir -p "${HOME}"/.local/share/fonts/NerdFontsSymbolsOnly
    curl -fsSL \
        https://github.com/ryanoasis/nerd-fonts/releases/latest/download/NerdFontsSymbolsOnly.tar.xz \
        | tar -xJ -C "${HOME}"/.local/share/fonts/NerdFontsSymbolsOnly
    fc-cache -f "${HOME}"/.local/share/fonts/NerdFontsSymbolsOnly
fi

# Claude Code
mkdir -p "${HOME}"/.claude/agents
ln -sf "${DOTFILES_DIR}"/.claude/CLAUDE.md "${HOME}"/.claude/CLAUDE.md
ln -sf "${DOTFILES_DIR}"/.claude/settings.json "${HOME}"/.claude/settings.json
ln -sf "${DOTFILES_DIR}"/.claude/agents/code-searcher.md "${HOME}"/.claude/agents/code-searcher.md

# Alacritty
mkdir -p "${HOME}"/.config/alacritty
ln -sf "${DOTFILES_DIR}"/alacritty.toml "${HOME}"/.config/alacritty/alacritty.toml
if [[ ! -d "${HOME}"/.config/alacritty/themes ]]; then
    git clone https://github.com/alacritty/alacritty-theme "${HOME}"/.config/alacritty/themes
fi
