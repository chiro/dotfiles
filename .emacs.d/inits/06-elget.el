;;; Code:
(setq el-get-sources
      '((:name my-ProofGeneral
               :description "ProofGeneral"
               :website "http://proofgeneral.inf.ed.ac.uk"
               :type http-tar
               :options ("xzf")
               :url "http://proofgeneral.inf.ed.ac.uk/releases/ProofGeneral-4.2.tgz"
               :build `(("cd" "ProofGeneral"))
               :load ("ProofGeneral/generic/proof-site.el")
               :info "./ProofGeneral/doc/")))

;; Install packages by el-get
(el-get 'sync '(my-ProofGeneral))
