(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

;; Make 'load' prefer the newest version of the file
(setq load-prefer-newer t)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

;; Install use-package if not there
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Always install the used packages
(setq use-package-always-ensure t)

;; init-loader
(use-package init-loader
  :ensure t
  :config (init-loader-load (concat user-emacs-directory "inits")))

;; theme
(use-package zenburn-theme
  :ensure t
  :config (load-theme 'zenburn t))

;; Put M-x customize stuff in a separate file
(setopt custom-file (concat user-emacs-directory "custom-file.el"))
(load custom-file 'noerror)
