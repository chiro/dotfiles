;==================================================
; scheme mode
;==================================================

(defvar scheme-program-name "gosh")
(require 'cmuscheme)

(defun scheme-other-frame ()
  "Run scheme on other frame"
  (interactive)
  (switch-to-buffer-other-frame
   (get-buffer-create "*scheme*"))
  (run-scheme scheme-program-name))

(defun scheme-other-window ()
  "Run scheme on other window"
  (interactive)
  (switch-to-buffer-other-window
   (get-buffer-create "*scheme*"))
  (run-scheme scheme-program-name))

(defun gauche-info ()
  (interactive)
  (switch-to-buffer-other-frame
   (get-buffer-create "*info*"))
  (info "/usr/local/info/gauche-refj.info.gz"))

(define-key global-map
  "\C-xS" 'scheme-other-frame)
(define-key global-map
  "\C-cS" 'scheme-other-window)
(define-key global-map
  "\C-cI" 'gauche-info)
