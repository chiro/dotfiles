(setq emacsd-path (expand-file-name user-emacs-directory))

(add-to-list 'load-path (concat emacsd-path "elisp"))

(require 'cask (expand-file-name "~/.cask/cask.el"))
(cask-initialize)

;; init-loader
(require 'init-loader)
(init-loader-load (concat emacsd-path "inits"))
