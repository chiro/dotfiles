(use-package counsel
  :defer 2
  :config
  (ivy-mode 1)
  (counsel-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-height 30)
  :bind (("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("C-x b" . ivy-switch-buffer)
         ("C-c g" . counsel-git)))

(use-package swiper
  :config
  (defvar swiper-include-line-number-in-search t)
  :bind (("C-s" . swiper)))

(use-package ivy-rich
  :config
  (ivy-rich-mode 1))
