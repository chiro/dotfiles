;;==================================================
;; ocaml mode
;;==================================================
(use-package tuareg
  :mode (("\\.ml[iylp]?" . tuareg-mode))
  :commands (tuareg-mode))

(autoload 'camldebug "camldebug" "Run the Caml debugger" t)
(dolist (ext '(".cmo" ".cmx" ".cma" ".cmxa" ".cmi"))
  (add-to-list 'completion-ignored-extensions ext))
