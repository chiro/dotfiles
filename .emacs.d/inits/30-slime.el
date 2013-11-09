;;==================================================
;; slime
;;==================================================
(require 'slime)
(add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))
(setq inferior-lisp-program "sbcl")
(slime-setup '(slime-repl))
(setq slime-net-coding-system 'utf-8-unix)

;;==================================================
;; slime utility
;;==================================================
(defun slime-kill-all-buffers ()
  "Kill all the slime related buffers. This is only used by the
 repl command sayoonara."
  (dolist (buf (buffer-list))
    (when (or (string= (buffer-name buf) slime-event-buffer-name)
              (string-match "^\\*inferior-lisp*" (buffer-name buf))
              (string-match
               "^\\*slime-repl\\[[0-9]+\\]\\*$" (buffer-name buf))
              (string-match "^\\*sldb .*\\*$" (buffer-name buf))
              (string-match "^\\*slime-*" (buffer-name buf)))
      (kill-buffer buf))))

(defun slime-smart-quit ()
  (interactive)
  (when (slime-connected-p)
    (slime-disconnect))
  (slime-kill-all-buffers))

(add-hook 'kill-emacs-hook 'slime-smart-quit)

;;==================================================
;; ac-slime -- auto complete for slime
;;==================================================
(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)

