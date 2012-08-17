(setq load-path (cons "~/.emacs.d/elisp" load-path))

;; init-loader
(require 'init-loader)
(init-loader-load "~/.emacs.d/inits")
