(use-package ddskk
  :ensure t
  :bind (("C-x j" . skk-mode))
  :config
  (setq skk-auto-insert-paren t)
  (setq-default skk-kutouten-type 'en))
