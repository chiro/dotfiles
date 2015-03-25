(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(el-get-bundle auto-complete)
(el-get-bundle anzu)
(el-get-bundle flycheck)
(el-get-bundle google-c-style)
(el-get-bundle helm)
(el-get-bundle helm-descbinds)
(el-get-bundle helm-ghq)
(el-get-bundle js2-mode)
(el-get-bundle json-mode)
(el-get-bundle popwin)
(el-get-bundle tuareg)
(el-get-bundle init-loader)
(el-get-bundle solarized-theme)
(el-get-bundle org)
(el-get-bundle go-mode)
(el-get-bundle markdown-mode)
(el-get-bundle tss)
(el-get-bundle web-mode)
(el-get-bundle yaml-mode)

;; Haskell
(el-get-bundle haskell-mode)
(el-get-bundle flycheck-haskell)

;; Ruby
(el-get-bundle ruby-block)
(el-get-bundle rspec-mode)
(el-get-bundle haml-mode)

;; Scala
(el-get-bundle sbt-mode)
(el-get-bundle scala-mode2)

;; Company mode
(el-get-bundle company)
(el-get-bundle company-ghc)
(el-get-bundle company-go)
(el-get-bundle company-c-headers)

;; git
(el-get-bundle git-commit-mode)
(el-get-bundle git-rebase-mode)
(el-get-bundle git-gutter)

(el-get-bundle pretty-mode)
(el-get-bundle projectile)
(el-get-bundle howm)
(el-get-bundle ddskk)

;; init-loader
(require 'init-loader)
(init-loader-load (concat user-emacs-directory "inits"))
