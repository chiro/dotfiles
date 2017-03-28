(defun js2-mode-indent-hook ()
  (setq js2-basic-offset 4))

(use-package js2-mode
  :init (add-hook 'js2-mode-hook 'js2-mode-indent-hook)
  :mode (("\\.js$" . js2-mode)))

(use-package json-mode
  :mode (("\\.json$" . json-mode)))
