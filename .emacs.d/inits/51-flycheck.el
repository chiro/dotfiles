(add-hook 'after-init-hook #'global-flycheck-mode)

(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-haskell-setup))
