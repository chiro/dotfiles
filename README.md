# dotfiles

Personal Linux desktop and development configuration.

## Prerequisites

The installer supports Arch Linux (`pacman`) and Debian-family systems
(`apt-get`). It expects Bash, Git, `sudo`, and a working network connection.

It bootstraps asdf and installs Ruby, ghq, peco, uv, and Node.js. Desktop
programs referenced by the configuration are not installed automatically yet:
XMonad and xmonad-contrib, Polybar, Alacritty, Nitrogen, fcitx5, xscreensaver,
brightnessctl, and the Ricty Diminished font must already be available.

## Install

```shell
./install.sh
```

The script creates these links:

| Repository path | Installed path |
| --- | --- |
| `.emacs.d/` | `~/.emacs.d` |
| `.bashrc`, `.bash_aliases` | `~/.bashrc`, `~/.bash_aliases` |
| `.gitconfig`, `.gitignore` | `~/.gitconfig`, `~/.gitignore` |
| `.gemrc` | `~/.gemrc` |
| `.tmux.conf` | `~/.config/tmux/tmux.conf` |
| `.xprofile` | `~/.xprofile` |
| `.xmonad/xmonad.hs` | `~/.xmonad/xmonad.hs` |
| `polybar.config.ini`, `polybar.launch.sh` | `~/.config/polybar/` |
| `.claude/` shared settings and agents | `~/.claude/` |
| `codex/rules/` | `~/.codex/rules` |
| `codex/skills/simplify/` | `~/.codex/skills/simplify` |
| `alacritty.toml` | `~/.config/alacritty/alacritty.toml` |
| `herdr.config.toml` | `~/.config/herdr/config.toml` |

If `~/.emacs.d` is already a real directory, the current installer leaves it
untouched; move it aside before installing if you want the repository version.

Codex rules use a directory symlink because Codex skips symlinked rule files.
If `~/.codex/rules` is a real directory, the installer backs it up under
`~/.codex/rules.backup.XXXXXX/rules` before creating the link. Restart Codex
after installation to load the rules.

The `simplify` skill reviews code for unnecessary complexity and applies focused
simplifications. Invoke it with, for example, `$simplify this change` or
`$simplify src/example/`.

Generated Emacs state, including undo history and recent files, is stored under
`$XDG_CACHE_HOME/emacs` (or `~/.cache/emacs`) rather than inside the repository.
See [docs/improvements.md](docs/improvements.md) for remaining cleanup work.
