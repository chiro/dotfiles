(use-package company
  :ensure t
  :diminish "comp"
  :config
  (use-package company-go
    :ensure t
    :config (add-to-list 'company-backends 'company-go))
  (global-company-mode))
