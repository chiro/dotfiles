(use-package python-mode
  :custom (python-indent 4)
  :mode (("\\.py$" . python-mode)))

(use-package python-docstring
  :hook python-mode)

(use-package pip-requirements :defer t)
