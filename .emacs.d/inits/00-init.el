;;==================================================
;; set load-path
;;==================================================
(setq load-path
      (append
       (list
        (expand-file-name "~/.emacs.d/elisp/auto-install")
        (expand-file-name "~/.emacs.d/elisp")
;        (expand-file-name "~/.emacs.d/elisp/anything-config")
;        (expand-file-name "~/.emacs.d/elisp/anything-config/extensions")
        (expand-file-name "~/.emacs.d/elisp/tuareg")
        (expand-file-name "~/.emacs.d/elisp/yatex")
        (expand-file-name "~/.emacs.d/elisp/slime"))
       load-path))


;; スタートアップ画面を非表示
(setq inhibit-startup-screen t)

;; *scratch* のメッセージを空に
(setq initial-scratch-message "")

