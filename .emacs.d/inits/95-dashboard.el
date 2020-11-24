(use-package dashboard
  :diminish
  (dashboard-mode page-break-lines-mode)
  :custom
  (dashboard-items '((recents . 15)
                     (projects . 5)
                     (bookmarks . 5)))
  :hook
  (after-init . dashboard-setup-startup-hook))
