# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal dotfiles repository containing configurations for various Linux desktop tools and applications. The `.xmonad` directory contains XMonad window manager configuration written in Haskell.

## XMonad Configuration

### Building and Installing
- XMonad configuration is in `xmonad.hs` 
- After editing, XMonad will automatically recompile on restart (Mod+Q)
- To manually compile: `xmonad --recompile`

### Configuration Structure
- Main configuration in `xmonad.hs:15-34` using the `defaults` record
- Custom keybindings added via `additionalKeysP` and `additionalKeys`
- Layout configuration in `myLayoutHook` (lines 45-57)
- Startup applications in `myStartupHook` (lines 59-64)
- Window management rules in `myManageHook` (lines 68-73)

### Key Components
- Uses Super key (mod4Mask) as modifier
- Alacritty as default terminal
- Integrates with polybar, nitrogen, fcitx5, and xscreensaver
- Custom workspaces: ["term", "emacs", "Web", "4", "5", "6", "7", "8", "9"]
- Automatic window placement for Emacs, Discord, and Steam applications

### Dependencies
The configuration depends on external applications started in myStartupHook:
- polybar (status bar)
- nitrogen (wallpaper manager)  
- fcitx5 (input method)
- xscreensaver (screen locker)

## Dotfiles Installation

From the root dotfiles directory, run `./install.sh` to:
- Install development tools via asdf (ruby, ghq, peco, uv, nodejs)
- Create symlinks for all configuration files including XMonad
