;==================================================
; c-mode, c++-mode
;==================================================
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

(setq c-hungry-delete-key t)

(setq auto-mode-alist
      (append
       '(("\\.c$"   . c-mode))
       '(("\\.h$"   . c++-mode))
       '(("\\.hpp$" . c++-mode))
       '(("\\.cpp$" . c++-mode))
       auto-mode-alist))
