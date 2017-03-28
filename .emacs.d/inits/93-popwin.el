(use-package popwin
  :defer 1
  :config
  (popwin-mode 1)

  (setq helm-samewindow nil)
  (push '("helm" :regexp t :height 0.4) popwin:special-display-config)
  (push '(compilation-mode :noselect t) popwin:special-display-config))
