(use-package counsel
  :diminish counsel-mode
  :bind (("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("C-c g" . counsel-git))
  :config
  (counsel-mode 1))

(use-package ivy
  :after counsel ; Ensure counsel is loaded before ivy tries to use it implicitly or explicitly
  :diminish ivy-mode
  :bind (("C-x b" . ivy-switch-buffer)
         ("C-c C-r" . ivy-resume))
  :custom
  ;; Add recent files to `ivy-switch-buffer`
  (ivy-use-virtual-buffers t)
  (ivy-count-format "(%d/%d) ")
  (ivy-height 10)
  (ivy-virtual-abbreviate nil)
  :config
  (ivy-mode 1))

(use-package swiper
  :after ivy ; Explicitly state dependency
  :bind (("C-s" . swiper)
         ("C-r" . swiper)))

(use-package ivy-rich
  :after ivy
  :config
  (ivy-rich-mode 1))
