;==================================================
; latex-mode
;==================================================
;;; Code:

(use-package latex-mode
  :config
  (bind-keys :map latex-mode-map
             ("C-c s" . skim-forward-search))
  :mode (("\\.tex" . latex-mode)))
(add-to-list 'auto-mode-alist '("\\.bib" . bibtex-mode))

(setq tex-default-mode 'latex-mode)

(defun tex-view ()
  (interactive)
  (tex-send-command "/usr/bin/open -a Skim.app" (tex-append tex-print-file ".pdf")))

(defun skim-forward-search ()
  (interactive)
  (let* ((ctf (buffer-name))
         (mtf (tex-main-file))
         (pf (concat (car (split-string mtf "\\.")) ".pdf"))
         (ln (format "%d" (line-number-at-pos)))
         (cmd "~/Applications/Skim.app/Contents/SharedSupport/displayline")
         (args (concat ln " " pf " " ctf)))
    (message (concat cmd " " args))
    (process-kill-without-query
     (start-process-shell-command "displayline" nil cmd args))))

(provide '24-tex)
;;; 24-tex.el ends here
