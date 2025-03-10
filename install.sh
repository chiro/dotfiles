#!/bin/bash

set -eu

if [[ ! -d "${HOME}"/.asdf ]]; then
    echo "asdf not found. Installing..."
    git clone https://github.com/asdf-vm/asdf.git "${HOME}"/.asdf --branch v0.13.1
    echo '. "$HOME/.asdf/asdf.sh"' >> "${HOME}"/.bashrc
    echo '. "$HOME/.asdf/completions/asdf.bash"' >> "${HOME}"/.bashrc
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
    echo 'eval "$(uv generate-shell-completion bash)"' >> ~/.bashrc
fi

# Create symlinks
if [[ ! -d "${HOME}"/.emacs.d ]]; then
    ln -sf $(pwd)/.emacs.d "${HOME}"/.emacs.d
fi

# bash
ln -sf $(pwd)/.bash_aliases "${HOME}"/.bash_aliases
ln -sf $(pwd)/.bashrc "${HOME}"/.bashrc

# git
ln -sf $(pwd)/.gitconfig "${HOME}"/.gitconfig
ln -sf $(pwd)/.gitignore "${HOME}"/.gitignore

ln -sf $(pwd)/.gemrc "${HOME}"/.gemrc

# tmux
mkdir -p "${HOME}"/.config/tmux
ln -sf $(pwd)/.tmux.conf "${HOME}"/.config/tmux/tmux.conf

# X/XMonad
ln -sf $(pwd)/.Xresources "${HOME}"/.Xresources
ln -sf $(pwd)/.xprofile "${HOME}"/.xprofile
mkdir -p "${HOME}"/.xmonad
ln -sf $(pwd)/.xmonad/xmonad.hs "${HOME}"/.xmonad/xmonad.hs
mkdir -p "${HOME}"/.config/polybar
ln -sf $(pwd)/polybar.config.ini "${HOME}"/.config/polybar/config.ini

# Alacritty
mkdir -p "${HOME}"/.config/alacritty
ln -sf $(pwd)/alacritty.toml "${HOME}"/.config/alacritty/alacritty.toml
if [[ ! -d "${HOME}"/.config/alacritty/themes ]]; then
    git clone https://github.com/alacritty/alacritty-theme "${HOME}"/.config/alacritty/themes
fi
