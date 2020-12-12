;==================================================
; Org mode
;==================================================
(use-package org
  :ensure t
  :mode (("\\.org$" . org-mode))
  :config
  (setq org-startup-truncated nil)
  (setq org-return-follows-link t)
  (setq org-directory "~/org/")
  (setq org-default-notes-file "notes.org"))

(use-package org-capture
  :config
  (setq org-capture-templates
        '(("t" "Todo" entry (file+headline "~/org/gtd.org" "Tasks")
           "* TODO %?\n  %i\n  %a")
          ("n" "note" entry (file+headline "~/org/notes.org" "Notes")
           "* %?\n %i\n %a\n %T")))
  :init
  (bind-key "C-c c" 'org-capture))
