(setq read-process-output-max (* 4 1024 1024)) ; 4MB

(use-package lsp-mode
  :hook ((rust-mode . lsp)
         (web-mode . lsp)
         (go-mode . lsp)
         (haskell-mode . lsp)
         (python-mode . lsp))
  :commands lsp)

(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
