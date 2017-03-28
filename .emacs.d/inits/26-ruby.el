(use-package ruby-mode
  :mode (("\\.rb$" . ruby-mode)
         ("Gemfile$" . ruby-mode))
  :init
  (add-hook 'ruby-mode-hook
            '(lambda ()
               (setq tab-width 2)
               (setq ruby-indent-level tab-width)
               (setq ruby-deep-indent-paren-style nil))))

(use-package haml-mode
  :mode (("\\.haml$" . haml-mode)))
