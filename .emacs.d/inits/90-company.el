(use-package company
  :config
  (use-package company-ghc
    :config (add-to-list 'company-backends 'company-ghc))
  (use-package company-go
    :config (add-to-list 'company-backends 'company-go))
  (global-company-mode))
