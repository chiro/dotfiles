(require 'typescript)
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))

(require 'tss)

;; Key bindings
(setq tss-popup-help-key "C-:")
(setq tss-jump-to-definition-key "C->")

(tss-config-default)
