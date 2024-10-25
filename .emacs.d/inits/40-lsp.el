(use-package lsp-mode
  :hook ((rust-mode . lsp)
        (web-mode . lsp))
  :commands lsp)

(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
