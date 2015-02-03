;;==================================================
;; Proof General
;;==================================================
;; I don't need any configuration about ProofGeneral.
;; el-get loads ProofGeneral.


;; Customization of PG for ssreflect syntax
;; Assia Mahboubi 2007

(defcustom coq-user-tactics-db
   '(("nat_congr" "ncongr"  "nat_congr" t "nat_congr")
     ("nat_norm" "nnorm"  "nat_norm" t "nat_norm")
     ("bool_congr" "bcongr"  "bool_congr" t "bool_congr")
     ("prop_congr" "prcongr"  "prop_congr" t "prop_congr")
     ("move" "m"  "move" t "move")
     ("set" "set"  "set # := #" t "set")
     ("have" "hv" "have # : #" t "have")
     ("congr" "con" "congr #" t "congr")
     ("wlog" "wlog" "wlog : / #" t "wlog")
     ("without loss" "wilog" "without loss #" t "without loss")
     ("unlock" "unlock" "unlock #" t "unlock")
     ("suffices" "suffices" "suffices # : #" t "suffices")
     ("suff" "suff" "suff # : #" t "suff")
)
   "Extended list of tactics, includings ssr and user defined ones")


(defcustom coq-user-commands-db
  '(("Prenex Implicits" "pi" "Prenex Implicits #" t "Prenex\\s-+Implicits")
    ("Hint View for" "hv" "Hint View for #" t "Hint\\s-+View\\s-+for")
    ("inside" "ins" nil f "inside")
    ("outside" "outs" nil f "outside")
    ("Canonical " nil "Canonical  #." t "Canonical")
)
   "Extended list of commands, includings ssr and user defined ones")

(defcustom coq-user-tacticals-db
  '(("last" "lst" nil t "last"))
  "Extended list of tacticals, includings ssr and user defined ones")

(defcustom coq-user-reserved-db
  '("is" "nosimpl" "of")
  "Extended list of keywords, includings ssr and user defined ones")

(defcustom coq-user-solve-tactics-db
  '(("done" nil "done" nil "done")
    )
   "Extended list of closing tactic(al)s, includings ssr and user defined ones")
;; This works only with the cvs version (> 3.7) of Proof General.
(defcustom coq-variable-highlight-enable nil
  "Activates partial bound variable highlighting"
)

(with-eval-after-load 'coq
  (print "In eval-after-load coq")
  (defun coq-mode-config-hook ()
    "coq-mode-config-hook"
    (auto-complete-mode)
    (turn-on-pretty-mode)
    (proof-electric-terminator-enable))
  (add-hook 'coq-mode-hook 'coq-mode-config-hook)

  (defun coq-goals-mode-config-hook ()
    "coq-goals-mode-config-hook"
    (turn-on-pretty-mode))
  (add-hook 'coq-goals-mode-hook 'coq-goals-mode-config-hook))
