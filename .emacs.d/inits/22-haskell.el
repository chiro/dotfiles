;==================================================
; haskell mode
;==================================================
(custom-set-variables
 '(haskell-tags-on-save t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t))

(with-eval-after-load 'haskell-mode
  (require 'ghc)

  (add-hook 'haskell-mode-hook 'my/haskell-mode-hook)
  (setq ghc-module-command (executable-find "ghc-mod")))

; ghc-mod
(setenv "PATH" (concat "~/.cabal/bin;" (getenv "PATH")))
(add-to-list 'exec-path "~/.cabal/bin")

(defun my/haskell-mode-hook ()
  (turn-on-haskell-doc-mode)
  (turn-on-haskell-indentation)
  (setq flycheck-checker 'haskell-ghc)

  (ghc-abbrev-init)
  (ghc-type-init)
  (unless ghc-initialized
    (ghc-comp-init)
    (setq ghc-initialized t))

  ;; for auto-complete
  (add-to-list 'ac-sources 'ac-source-ghc-mod))
