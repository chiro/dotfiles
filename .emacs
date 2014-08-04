(setq load-path (cons "~/.emacs.d/elisp" load-path))

(require 'cask "~/.cask/cask.el")
(cask-initialize)

;; init-loader
(require 'init-loader)
(init-loader-load "~/.emacs.d/inits")
