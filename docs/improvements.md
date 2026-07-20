# Repo review — potential improvements and issues

Reviewed: 2026-07-12; revalidated 2026-07-20 against source revision `34c2d8f`.
Every git-tracked file was read; the suspicious findings below were verified against
the actual toolchain (GHC typecheck, installed ELPA package sources) rather than
assumed.

Ordered by severity. Check items off as they are fixed.

## Bugs (actually broken)

- [x] **`.xmonad/xmonad.hs:68-73` — did not compile.** `myManageHook` chained rules
  with `.` instead of `,`. GHC rejected it: *"cannot mix `-->` [infix 0] and `-->`
  [infix 0] in the same infix expression"* (confirmed with `ghc -fno-code`). Fixed in
  commit `f0d09a7` by making it a plain list:

  ```haskell
  myManageHook = composeAll
    [ className =? "Emacs"   --> doShift "emacs"
    , className =? "Discord" --> doShift "4"
    , className =? "Steam"   --> doShift "5"
    , manageDocks
    ]
  ```

- [x] **`.emacs.d/inits/20-proglangs.el:89` — terraform format-on-save never
  activates.** `:hook (terraform . terraform-format-on-save)` adds to a nonexistent
  `terraform-hook`. The installed package provides a minor mode, so it should be
  `:hook (terraform-mode . terraform-format-on-save-mode)`.

- [x] **`.emacs.d/inits/06-anzu.el:7` — typo sets a dead variable.** The real option
  is `anzu-deactivate-region` (verified against the installed anzu.el);
  `anzu-deactive-region` silently does nothing.

- [x] **`.gemrc` — options removed from RubyGems.** `--no-rdoc --no-ri` were removed
  in RubyGems 3 (2018); `gem install` errors on them. Modern equivalent:
  `gem: --no-document`.

- [x] **`.emacs.d/inits/11-gptel.el:39` — default model likely doesn't take effect.**
  `(setopt gptel-model gemini-model)` sets a string where gptel expects a symbol, and
  picking a non-default backend also requires setting `gptel-backend` — otherwise the
  default backend remains ChatGPT. Test with a fresh `M-x gptel` to confirm.

## Security / privacy

- [x] **Plaintext secret history inside the repo tree.** `~/.emacs.d` is symlinked
  into the repo, and `undo-tree-auto-save-history` writes to `.emacs.d/undo/` — which
  contains undo history for `.authinfo` (holds Anthropic/Gemini API keys per the
  gptel comments), `.ssh/config`, and ICPC `secrets2023/teams.csv`. They are only
  kept out of git by the generic `*~` pattern. Move the undo dir out of the repo
  (e.g. `~/.cache/emacs/undo`) and delete the existing files. If this tree has ever
  been shared, indexed, or backed up externally, rotate the affected credentials;
  consider `.authinfo.gpg` to protect the live credential file. Also relocate
  `auto-save-list/`, `recentf`, and `transient/history.el` for privacy and cleanliness,
  but distinguish them from undo history: they generally expose filenames, metadata,
  or command history rather than full historical file contents.

- [ ] **The root and XMonad `CLAUDE.md` files are gitignored and not versioned.**
  `.gitignore:78` ignores `CLAUDE.md` globally, so `dotfiles/CLAUDE.md` and
  `.xmonad/CLAUDE.md` exist only on this machine — a fresh clone loses them. (The
  separate `.claude/CLAUDE.md` is already tracked.) If unintended, add both
  `!/CLAUDE.md` and `!/.xmonad/CLAUDE.md` (or force-add both files). Related:
  `.xmonad/CLAUDE.md` is stale — it describes workspaces
  `["term", "emacs", "Web", "Slack", ...]` and Slack placement rules that no longer
  match the code.

- [ ] **`.claude/settings.local.json` is committed and symlinked, yet `.gitignore:84`
  ignores it everywhere.** "Local" settings are meant to be per-machine; committing
  them contradicts the ignore rule. Either fold its contents into `settings.json`, or
  remove it from git with `git rm --cached`. In the latter case, also change
  `install.sh:85` so a fresh clone does not create a symlink to a missing file; let
  Claude create the local file or copy an ignored template instead.

## Portability / robustness

- [ ] **`install.sh` mixes package managers.** `sudo apt-get install` for ruby build
  deps (line 15) but `pacman -S` for the font (line 78). On an Arch box the ruby
  branch dies, and `set -e` aborts the whole script. Pick one or detect the distro.

- [ ] **`install.sh` inconsistencies.** Ruby is the only asdf tool without an
  `asdf global`; asdf is pinned to the aging v0.13.1 release. The pin means
  `asdf global` will not spontaneously disappear, but upgrading to the rewritten Go
  implementation in 0.16+ requires replacing it with `asdf set`. The `~/.emacs.d`
  symlink is silently skipped if a real directory already exists; nothing installs
  the programs the configs depend on (xmonad, polybar, alacritty, nitrogen, fcitx5,
  xscreensaver, brightnessctl, and the RictyDiminished font used by both alacritty and
  polybar — only the Nerd Font symbols are handled).

- [ ] **Hardware-specific values committed.** `wlp3s0` / `enp2s0` in
  `polybar.config.ini` (use `interface-type = wireless` / `wired` instead),
  `amdgpu_bl1` backlight card, `BAT0`.

- [ ] **`.latexmkrc:12` is macOS-only.** `$pdf_previewer = "open -ga
  ~/Applications/Skim.app"` — on Linux use zathura/evince, or make it conditional.

## Minor

- [ ] `.bash_aliases:8-10` — the `A && B || C && D || E` chain is left-associative,
  so even when `gtac` is found, the later `&& tac="tac"` overwrites it; the fallback
  never worked (harmless on Linux, but an `if/elif` would be correct). Also
  `peco-git-add` (`awk '{print $2}'`) breaks on paths with spaces and rename entries,
  and `cd ${selected_file}` in `peco-ghq-cd` is unquoted (`$LBUFFER` there is a
  zsh-ism, always empty in bash).
- [ ] `.tmux.conf:6` — `default-terminal 'xterm-256color'` is discouraged inside
  tmux; `tmux-256color` (plus `terminal-overrides` for truecolor) is the correct
  value.
- [x] `.emacs.d/inits/05-editing.el:36` — `(concat user-emacs-directory "/undo")`
  produces a double slash since `user-emacs-directory` already ends in `/`.
- [ ] `.emacs.d/inits/01-display.el` — global `show-trailing-whitespace` also lights
  up special/terminal buffers; commonly scoped to `prog-mode-hook`/`text-mode-hook`.
- [ ] `.emacs.d/inits/20-proglangs.el` — file-extension regexes use `$` and the OCaml
  one (`"\\.ml[iylp]?"`) is unanchored, so it matches e.g. `foo.mlx`; the convention
  is `\\.ml[iylp]?\\'`. Most `:mode` entries there (`.json`, `.go`, `.rs`, `.py`) also
  duplicate what the packages already register via autoloads. The same applies to the
  `.md` entry in `.emacs.d/inits/33-markdown.el`.
- [ ] `.gitconfig` — the `[color]` block has been the default since git 1.8.4 and can
  be deleted; `push.autoSetupRemote = true` and `rebase.autostash = true` would fit
  the alias-heavy workflow.
- [ ] `README.md` is only eight lines and contains almost no guidance; what gets
  symlinked where and the prerequisites (currently only in the uncommitted CLAUDE.md)
  belong in the README.
