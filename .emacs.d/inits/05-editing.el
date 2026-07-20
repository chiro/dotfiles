;; delete region
(delete-selection-mode t)

;; Don't make ~file
(setopt make-backup-files nil)

;; Don't make .#* files
(setopt auto-save-default nil)

(setq-default indent-tabs-mode nil ; no use tab mode
              tab-width        4   ; size of tab is 4
              )

;; Keep generated state outside the symlinked dotfiles repository.
(defconst chiro-emacs-cache-directory
  (file-name-as-directory
   (expand-file-name "emacs" (or (getenv "XDG_CACHE_HOME") "~/.cache"))))

(dolist (directory '("" "auto-save-list" "undo"))
  (make-directory (expand-file-name directory chiro-emacs-cache-directory) t))

(setopt auto-save-list-file-prefix
        (expand-file-name "auto-save-list/.saves-" chiro-emacs-cache-directory)
        recentf-save-file
        (expand-file-name "recentf" chiro-emacs-cache-directory))
(setq transient-history-file
      (expand-file-name "transient-history.el" chiro-emacs-cache-directory))

; 最近使ったファイル
(recentf-mode)

;; auto reload the buffer.
(setopt auto-revert-avoid-polling t)
(setopt auto-revert-interval 5)
(setopt auto-revert-check-vc-info t)
(global-auto-revert-mode t)

;; No Duplicates in the Kill Ring
(setq kill-do-not-save-duplicates t)

;; uniquify
(use-package uniquify
  :ensure nil ;; It's needed because uniquify is the built-in module.
  :defer 1
  :config
  (setopt uniquify-buffer-name-style 'post-forward-angle-brackets))

;; undo-tree
(use-package undo-tree
  :defer 1
  :diminish undo-tree-mode
  :config
  (global-undo-tree-mode)
  (setopt undo-tree-auto-save-history t)
  (setopt undo-tree-history-directory-alist
          `(("." . ,(expand-file-name "undo" chiro-emacs-cache-directory)))))

;; pixel-scroll
(use-package pixel-scroll
  :if (>= (string-to-number emacs-version) 29)
  :ensure nil
  :bind
  ([remap scroll-up-command] . pixel-scroll-interpolate-down)
  ([remap scroll-down-command] . pixel-scroll-interpolate-up)
  :custom
  (pixel-scroll-precision-interpolate-page t)
  :init
  (pixel-scroll-precision-mode 1))

;; which-key: show a popup of available keybindings
(use-package which-key
  :config
  (which-key-mode))

;; Auto-Chmod Scripts on Save
(add-hook 'after-save-hook
          #'executable-make-buffer-file-executable-if-script-p)
