;==================================================
; C/C++
;==================================================
(use-package google-c-style
  :ensure t
  :defer 1
  :hook (c-mode-common-hook . google-set-c-style)
  :hook (c-mode-common-hook . google-make-newline-indent)
  :mode (("\\.c$" . c-mode)
         ("\\.h$" . c++-mode)
         ("\\.cpp$" . c++-mode)
         ("\\.hpp$" . c++-mode)))

;;==================================================
;; Haskell
;;==================================================
(use-package haskell-mode
  :ensure t
  :mode (("\\.hs$" . haskell-mode))
  :hook (haskell-mode-hook my/haskell-mode-hook))

(defun my/haskell-mode-hook ()
  (turn-on-haskell-doc-mode)
  (turn-on-haskell-indentation))

(use-package consult-hoogle
  :ensure t)

;;==================================================
;; OCaml
;;==================================================
(use-package tuareg
  :mode (("\\.ml[iylp]?" . tuareg-mode))
  :commands (tuareg-mode))

(autoload 'camldebug "camldebug" "Run the Caml debugger" t)
(dolist (ext '(".cmo" ".cmx" ".cma" ".cmxa" ".cmi"))
  (add-to-list 'completion-ignored-extensions ext))

;;==================================================
;; Web mode
;;==================================================
(use-package web-mode
  :mode (("\\.erb$" . web-mode)
         ("\\.html$" . web-mode)
         ("\\.ts[x]?$" . web-mode)
         ("\\.js[x]?$" . web-mode)))

;;==================================================
;; Ruby
;;==================================================
(use-package haml-mode
  :mode (("\\.haml$" . haml-mode)))

;;==================================================
;; Golang
;;==================================================
(use-package go-mode
  :mode (("\\.go$" . go-mode))
  :config
  ;; Do "go fmt" before save
  (add-hook 'before-save-hook 'gofmt-before-save))

;;==================================================
;; Python
;;==================================================
(use-package python-mode
  :custom (python-indent 4)
  :mode (("\\.py$" . python-mode)))

(use-package python-docstring
  :hook python-mode)

(use-package pip-requirements :defer t)

;;==================================================
;; Rust
;;==================================================
(add-to-list 'exec-path (expand-file-name "~/.cargo/bin/"))

(use-package rust-mode
  :mode (("\\.rs$" . rust-mode))
  :commands (rust-mode)
  :custom (rust-format-on-save t))

;;==================================================
;; Terraform
;;==================================================
(use-package terraform-mode
  :defer 1
  :hook (terraform . terraform-format-on-save))

(use-package terraform-doc)

;;==================================================
;; Misc
;;==================================================
;; Major mode for YAML
(use-package yaml-mode)

;; Git
(use-package magit)

;; JSON
(use-package json-mode
  :mode (("\\.json$" . json-mode)))
