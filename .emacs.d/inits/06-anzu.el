(use-package anzu
  :defer 1
  :config
  (global-anzu-mode +1)
  (custom-set-variables
   '(anzu-mode-lighter "")
   '(anzu-deactive-region t)
   '(anzu-search-threshold 1000)))
