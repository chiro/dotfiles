;==================================================
; c-mode, c++-mode
;==================================================
(use-package google-c-style
  :init
  (add-hook 'c-mode-common-hook 'google-set-c-style)
  (add-hook 'c-mode-common-hook 'google-make-newline-indent)
  :ensure t
  :defer 1
  :config
  (setq c-hungry-delete-key t)

  (setq auto-mode-alist
        (append
         '(("\\.c$"   . c-mode))
         '(("\\.h$"   . c++-mode))
         '(("\\.hpp$" . c++-mode))
         '(("\\.cpp$" . c++-mode))
         auto-mode-alist)))
