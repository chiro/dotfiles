(require 'package)

;; Marmalade
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/")
             '("melpa" . "http://melpa.milkbox.net/packages/"))
(setq package-user-dir (concat user-emacs-directory "elpa"))

(package-initialize)

(defvar my/packages
  '(auto-complete
    ac-slime
    haskell-mode
    tuareg
    org
    solarized-theme
    )
  "A list of packages to install from MELPA or ELPA at launch.")

;; Install Melpa packages
(dolist (package my/packages)
  (unless (package-installed-p package)
    (package-install package)))
