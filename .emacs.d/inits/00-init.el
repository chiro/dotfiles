;; スタートアップ画面を非表示
(setopt inhibit-startup-screen t)

;; *scratch* のメッセージを空に
(setopt initial-scratch-message "")

;; server start for emacs-client
(use-package server
  :ensure nil ;; It's needed because server is the built-in module.
  :defer 1
  :config
  (unless (server-running-p)
    (server-start)))

;; Ask before exit
(setopt confirm-kill-emacs 'y-or-n-p)

(setopt history-delete-duplicates t)

(use-package diminish)

;; See https://github.com/emacs-lsp/lsp-mode/issues/3516
(setopt backup-by-copying t)
