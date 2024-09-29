;; delete region
(delete-selection-mode t)

;; Don't make ~file
(setq make-backup-files nil)

;; Don't make .#* files
(setq auto-save-default nil)

(setq-default indent-tabs-mode nil ; no use tab mode
              tab-width        4   ; size of tab is 4
              )

; C-c c で compile コマンドを呼び出す
(define-key mode-specific-map "c" 'compile)

; 最近使ったファイル
(recentf-mode)

;; Ignore case when do completion
(setq completion-ignore-case t)

;; auto reload the buffer.
(global-auto-revert-mode t)

;; uniquify
(use-package uniquify
  :ensure nil ;; It's needed because uniquify is the built-in module.
  :defer 1
  :config
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets))

;; undo-tree
(use-package undo-tree
  :defer 1
  :config
  (global-undo-tree-mode)
  (setq undo-tree-auto-save-history t)
  (setq undo-tree-history-directory-alist `(("." .  ,(concat user-emacs-directory "/undo")))))

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
