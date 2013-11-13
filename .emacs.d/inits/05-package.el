(require 'package)

(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
  '("marmalade" . "http://marmalade-repo.org/packages/") t)
(setq package-user-dir (concat user-emacs-directory "elpa"))

(package-initialize)

(defvar my/packages
  '(auto-complete
    ac-slime
    haskell-mode
    helm
    helm-descbinds
    js2-mode
    rspec-mode
    ruby-block
    slime
    slime-repl
    solarized-theme
    tuareg
    org
    )
  "A list of packages to install from MELPA or ELPA at launch.")

;; Install Melpa packages
(dolist (package my/packages)
  (unless (package-installed-p package)
    (package-install package)))
