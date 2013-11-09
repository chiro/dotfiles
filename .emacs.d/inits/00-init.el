;; スタートアップ画面を非表示
(setq inhibit-startup-screen t)

;; *scratch* のメッセージを空に
(setq initial-scratch-message "")

;; server start for emacs-client
(require 'server)
(unless (server-running-p)
  (server-start))
