(use-package go-mode
  :mode (("\\.go$" . go-mode))
  :config
  ;; Do "go fmt" before save
  (add-hook 'before-save-hook 'gofmt-before-save))
