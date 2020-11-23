(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

(when (require 'package nil t)
  (add-to-list 'package-archives
               '("stable-melpa" . "https://stable.melpa.org/packages/") t)
  (add-to-list 'package-archives
               '("melpa" . "https://melpa.org/packages/") t)
  (package-initialize)
  ;; Install use-package if not there
  (unless (require 'use-package nil t)
    (unless package-archive-contents (package-refresh-contents))
    (package-install 'use-package)))

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
