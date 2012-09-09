(require 'package)

;; Marmalade
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(setq package-user-dir (concat user-emacs-directory "elpa"))

(package-initialize)
