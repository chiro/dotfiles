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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
