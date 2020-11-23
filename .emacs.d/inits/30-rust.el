;;; Code:
(add-to-list 'exec-path (expand-file-name "~/.cargo/bin/"))

(use-package rust-mode
  :init
  (add-hook 'rust-mode-hook
            (lambda ()
              (setq indent-tabs-mode nil)))
  :mode (("\\.rs$" . rust-mode))
  :commands (rust-mode)
  :config
  (setq-default rust-format-on-save t))

(provide '30-rust)
;;; 30-rust.el ends here
