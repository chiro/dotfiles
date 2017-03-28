;==================================================
; elisp mode
;==================================================
(setq auto-mode-alist
      (append
       '(("/.emacs.*" . emacs-lisp-mode))
       '(("\\.el" . emacs-lisp-mode))
       auto-mode-alist))
