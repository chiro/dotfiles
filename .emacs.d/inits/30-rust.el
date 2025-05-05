;;; Code:
(add-to-list 'exec-path (expand-file-name "~/.cargo/bin/"))

(use-package rust-mode
  :mode (("\\.rs$" . rust-mode))
  :commands (rust-mode)
  :custom (rust-format-on-save t))

(provide '30-rust)
;;; 30-rust.el ends here
