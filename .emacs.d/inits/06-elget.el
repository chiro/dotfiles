;;; Code:
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(setq el-get-generate-autoloads nil)

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(setq el-get-sources
      '((:name ddskk-15.1
               :description "A Japanese input method on Emacs."
               :website "http://openlab.ring.gr.jp/skk/ddskk.html"
               :type http-tar
               :options ("xzf")
               :autoloads nil
               :url "http://openlab.ring.gr.jp/skk/maintrunk/ddskk-15.1.tar.gz"
               :info "doc/skk.info"
               :features ("skk-setup")
               :build `((,el-get-emacs "-batch" "-q" "-no-site-file" "-l" "SKK-MK" "-f" "SKK-MK-compile")
                        (,el-get-emacs "-batch" "-q" "-no-site-file" "-l" "SKK-MK" "-f" "SKK-MK-compile-info")
                        ("mv" "skk-setup.el.in" "skk-setup.el")))
        (:name my-ProofGeneral
               :description "ProofGeneral"
               :website "http://proofgeneral.inf.ed.ac.uk"
               :type http-tar
               :options ("xzf")
               :url "http://proofgeneral.inf.ed.ac.uk/releases/ProofGeneral-4.2.tgz"
               :build `(("cd" "ProofGeneral"))
               :load ("ProofGeneral/generic/proof-site.el")
               :info "./ProofGeneral/doc/")))

;; Install packages by el-get
(el-get 'sync '(howm))
(el-get 'sync '(ddskk-15.1))
(el-get 'sync '(my-ProofGeneral))
