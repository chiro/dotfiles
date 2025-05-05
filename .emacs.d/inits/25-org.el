;==================================================
; Org mode
;==================================================
(use-package org
  :ensure t
  :mode (("\\.org$" . org-mode))
  :custom (org-startup-truncated nil)
  :custom (org-return-follows-link t)
  :custom (org-directory "~/org/")
  :custom (org-default-notes-file "notes.org"))

(use-package org-capture
  :ensure nil
  :custom
  (org-capture-templates
        '(("t" "Todo" entry (file+headline "~/org/gtd.org" "Tasks")
           "* TODO %?\n  %i\n  %a")
          ("n" "note" entry (file+headline "~/org/notes.org" "Notes")
           "* %?\n %i\n %a\n %T")))
  :bind ("C-c c" . 'org-capture))
