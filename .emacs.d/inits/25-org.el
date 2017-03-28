;==================================================
; Org mode
;==================================================
(use-package org-install
  :mode (("\\.org$" . org-mode))
  :config
  (setq org-startup-truncated nil)
  (setq org-return-follows-link t)
  (setq org-directory "~/memo/")
  (setq org-default-notes-file (concat org-directory "agenda.org"))
  (setq org-remember-templates
        '(("Todo" ?t "** TODO %?\n %i\n %a\n %t" nil "Inbox")
          ("Bug"  ?b "** TODO $? :bug:\n %i\n %a\n %t" nil "Inbox")
          ("Idea" ?i "** %?\n %i\n %a\n %t" nil "New Ideas")
          ("Wait" ?w "** TODO %? :wait:\n %i\n %a\n %t" nil "Wait")
          ))
  )
