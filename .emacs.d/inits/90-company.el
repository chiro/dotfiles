(use-package company
  :config
  (use-package company-go
    :config (add-to-list 'company-backends 'company-go))
  (global-company-mode))
