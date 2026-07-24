;==================================================
; C/C++
;==================================================
(use-package google-c-style
  :ensure t
  :defer 1
  :hook (c-mode-common . google-set-c-style)
  :hook (c-mode-common . google-make-newline-indent))

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;;==================================================
;; Haskell
;;==================================================
(use-package haskell-mode
  :ensure t
  :hook (haskell-mode . my/haskell-mode-hook))

(defun my/haskell-mode-hook ()
  (turn-on-haskell-doc-mode)
  (turn-on-haskell-indentation))

(use-package consult-hoogle
  :ensure t)

;;==================================================
;; OCaml
;;==================================================
(use-package tuareg
  :commands (tuareg-mode))

(autoload 'camldebug "camldebug" "Run the Caml debugger" t)
(dolist (ext '(".cmo" ".cmx" ".cma" ".cmxa" ".cmi"))
  (add-to-list 'completion-ignored-extensions ext))

;;==================================================
;; Web mode
;;==================================================
(use-package web-mode
  :mode (("\\.erb\\'" . web-mode)
         ("\\.html\\'" . web-mode)
         ("\\.tsx?\\'" . web-mode)
         ("\\.jsx?\\'" . web-mode)))

;;==================================================
;; Ruby
;;==================================================
(use-package haml-mode :defer t)

;;==================================================
;; Golang
;;==================================================
(use-package go-mode
  :hook (go-mode . (lambda () (add-hook 'before-save-hook #'gofmt-before-save nil t))))

;;==================================================
;; Python
;;==================================================
(use-package python-mode
  :defer t
  :custom (python-indent 4))

(use-package python-docstring
  :hook python-mode)

(use-package pip-requirements :defer t)

;;==================================================
;; Rust
;;==================================================
(add-to-list 'exec-path (expand-file-name "~/.cargo/bin/"))

(use-package rust-mode
  :commands (rust-mode)
  :custom (rust-format-on-save t))

;;==================================================
;; Terraform
;;==================================================
(use-package terraform-mode
  :defer 1
  :hook (terraform-mode . terraform-format-on-save-mode))

(use-package terraform-doc)

;;==================================================
;; Misc
;;==================================================
;; Major mode for YAML
(use-package yaml-mode)

;; Git
(use-package magit)

;; JSON
(use-package json-mode :defer t)
