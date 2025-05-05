(use-package terraform-mode
  :defer 1
  :hook (terraform . terraform-format-on-save))

(use-package terraform-doc)
