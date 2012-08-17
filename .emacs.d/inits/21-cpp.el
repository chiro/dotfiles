;==================================================
; c-mode, c++-mode
;==================================================
(add-hook 'c-mode-common-hook
          '(lambda ()
             (c-set-style "k&r")
             (setq c-basic-offset 4)))

(setq auto-mode-alist
      (append
       '(("\\.c$"   . c-mode))
       '(("\\.h$"   . c++-mode))
       '(("\\.hpp$" . c++-mode))
       '(("\\.cpp$" . c++-mode))
       auto-mode-alist))
