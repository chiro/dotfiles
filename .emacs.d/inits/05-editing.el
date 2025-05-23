;; delete region
(delete-selection-mode t)

;; Don't make ~file
(setopt make-backup-files nil)

;; Don't make .#* files
(setopt auto-save-default nil)

(setq-default indent-tabs-mode nil ; no use tab mode
              tab-width        4   ; size of tab is 4
              )

; 最近使ったファイル
(recentf-mode)

;; auto reload the buffer.
(setopt auto-revert-avoid-polling t)
(setopt auto-revert-interval 5)
(setopt auto-revert-check-vc-info t)
(global-auto-revert-mode t)

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
  (setopt undo-tree-history-directory-alist `(("." .  ,(concat user-emacs-directory "/undo")))))

;; pixel-scroll
(use-package pixel-scroll
  :if (>= (string-to-number emacs-version) 29)
  :ensure nil
  :bind
  ([remap scroll-up-command] . pixel-scroll-interpolate-up)
  ([remap scroll-down-command] . pixel-scroll-interpolate-down)
  :custom
  (pixel-scroll-precision-interpolate-page t)
  :init
  (pixel-scroll-precision-mode 1))

;; which-key: show a popup of available keybindings
(use-package which-key
  :config
  (which-key-mode))

;==================================================
; スクリプトを保存するとき、自動的に chmod +x する
;==================================================
(defun make-file-executable ()
  "Make the file of this buffer executable, when it is a script source."
  (save-restriction
    (widen)
    (if (string= "#!"
                 (buffer-substring-no-properties 1
                                                 (min 3 (point-max))))
        (let ((name (buffer-file-name)))
          (or (equal ?. (string-to-char (file-name-nondirectory name)))
              (let ((mode (file-modes name)))
                (set-file-modes name (logior mode (logand (/ mode 4) 73)))
                (message (concat "Wrote " name " (+x)"))))))))
(add-hook 'after-save-hook 'make-file-executable)
