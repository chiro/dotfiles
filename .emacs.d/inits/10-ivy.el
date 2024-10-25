(use-package counsel
  :config
  (counsel-mode 1)
  :diminish counsel-mode
  :bind (("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("C-c g" . counsel-git)))

(use-package ivy
  :after (counsel)
  :diminish ivy-mode
  :bind (("C-x b" . ivy-switch-buffer)
         ("C-c C-r" . ivy-resume))
  :config
  (ivy-mode 1)

  ;; Add recent files to `ivy-switch-buffer`
  (setq ivy-use-virtual-buffers t)

  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-height 10)
  (setq ivy-virtual-abbreviate nil))

(use-package swiper
  :config
  (defvar swiper-include-line-number-in-search t)
  :bind (("C-s" . swiper)
         ("C-r" . swiper--isearch-backward)))

(use-package ivy-rich
  :config
  (ivy-rich-mode 1))
