;==================================================
; c-mode, c++-mode
;==================================================
(use-package google-c-style
  :ensure t
  :defer 1
  :hook (c-mode-common-hook . google-set-c-style)
  :hook (c-mode-common-hook . google-make-newline-indent)
  :mode (("\\.c$" . c-mode)
         ("\\.h$" . c++-mode)
         ("\\.cpp$" . c++-mode)
         ("\\.hpp$" . c++-mode)))
