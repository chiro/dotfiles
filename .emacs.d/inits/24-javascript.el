(defun js2-mode-indent-hook ()
  (setq js2-basic-offset 4))
(add-hook 'js2-mode-hook 'js2-mode-indent-hook)

(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
