(use-package python-mode
  :init
  (add-hook 'python-mode-hook
            '(lambda()
               (setq indent-tabs-mode nil)
               (setq indent-level 4)
               (setq python-indent 4)))
  :mode (("\\.py$" . python-mode)))
