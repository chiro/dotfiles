(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(setq el-get-generate-autoloads nil)

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

;; Install packages by el-get
(el-get 'sync '(howm))
