(use-package company
  :ensure t
  :config
  (use-package company-go
    :ensure t
    :config (add-to-list 'company-backends 'company-go))
  (global-company-mode))
