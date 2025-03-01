;==================================================
; haskell mode
;==================================================
(use-package haskell-mode
  :ensure t
  :mode (("\\.hs$" . haskell-mode))
  :config
  (add-hook 'haskell-mode-hook 'my/haskell-mode-hook))

(defun my/haskell-mode-hook ()
  (turn-on-haskell-doc-mode)
  (turn-on-haskell-indentation))

(use-package consult-hoogle
  :ensure t)
