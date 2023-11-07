;==================================================
; typescript-mode
;==================================================
;;; Code:

(use-package typescript-mode
  :mode (("\\.ts" . typescript-mode)))

(use-package tss
  :bind (("C-:" . tss-popup-help-key)
         ("C->" . tss-jump-to-definition-key))
  :config (tss-config-default))

(provide '24-typescript)
;;; 24-typescript.el ends here
