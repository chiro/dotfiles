(use-package projectile
  :defer 1
  :config
  (projectile-global-mode)
  (setq projectile-completion-system 'helm))
