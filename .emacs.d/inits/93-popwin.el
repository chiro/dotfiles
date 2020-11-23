(use-package popwin
  :defer 1
  :config
  (popwin-mode 1)
  (push '(compilation-mode :noselect t) popwin:special-display-config))
