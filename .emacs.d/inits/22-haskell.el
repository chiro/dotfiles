;==================================================
; haskell mode
;==================================================
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'haskell-indentation-mode)
(custom-set-variables
 '(haskell-tags-on-save t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t))

; ghc-mod
(setenv "PATH" (concat "~/.cabal/bin;" (getenv "PATH")))
(add-to-list 'exec-path "~/.cabal/bin")
(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))
