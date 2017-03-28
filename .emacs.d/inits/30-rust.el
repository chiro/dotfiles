;;; Code:
(add-to-list 'exec-path (expand-file-name "~/.cargo/bin/"))

(use-package rust-mode
  :init
  (add-hook 'rust-mode-hook
            (lambda ()
              (racer-mode)))
  :mode (("\\.rs$" . rust-mode))
  :commands (rust-mode)
  :config
  (setq-default rust-format-on-save t)
  (use-package racer
    :init
    (add-hook 'racer-mode-hook #'eldoc-mode)
    ))

(provide '30-rust)
;;; 30-rust.el ends here
