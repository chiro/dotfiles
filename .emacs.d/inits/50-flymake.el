;==================================================
; flymake
;==================================================
(require 'flymake)
(custom-set-faces '(flymake-errline ((((class color)) (:background "Pink" :underline "Red"))))
                  '(flymake-warnline ((((class color)) (:background "LighBlue" :underline "Yellow")))))

;;==================================================
;; flymake for c++
;;==================================================
;; (defun flymake-cc-init ()
;;   (let* ((temp-file   (flymake-init-create-temp-buffer-copy
;;                        'flymake-create-temp-inplace))
;;          (local-file  (file-relative-name
;;                        temp-file                       (file-name-directory buffer-file-name))))
;;     (list "g++" (list "-Wall" "-Wextra" "-fsyntax-only" local-file))))

;; (push '("\\.cpp$" flymake-cc-init) flymake-allowed-file-name-masks)

;; (add-hook 'c++-mode-hook
;;           '(lambda ()
;;              (flymake-mode t)))

;;==================================================
;; flymake for ocaml
;;==================================================
(add-to-list 'exec-path "~/bin")
(defun flymake-ocaml-init ()
  (flymake-simple-make-init-impl
   'flymake-create-temp-with-folder-structure nil nil
   (file-name-nondirectory buffer-file-name)
   'flymake-get-ocaml-cmdline))
(defun flymake-get-ocaml-cmdline (source base-dir)
  (list "ocaml_flycheck.pl"
        (list source base-dir)))

(setq flymake-allowed-file-name-masks
      '((".+\\.ml[yilp]?$" flymake-ocaml-init)))
(setq flymake-err-line-patterns
      '(("^\\(\.+\.ml[yilp]?\\|\.lhs\\):\\([0-9]+\\):\\([0-9]+\\):\\(.+\\)" 1 2 3 4)))
;; (push '(".+\\.ml[yilp]?$" flymake-ocaml-init flymake-simple-java-cleanup)
;;       flymake-allowed-file-name-masks)
;; (push '("^\\(\.+\.ml[yilp]?\\|\.lhs\\):\\([0-9]+\\):\\([0-9]+\\):\\(.+\\)"
;;         1 2 3 4) flymake-err-line-patterns)

(defun credmp/flymake-display-err-minibuf () 
  "Displays the error/warning for the current line in the minibuffer"
  (interactive)
  (let* ((line-no             (flymake-current-line-no))
         (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
         (count               (length line-err-info-list)))
    (while (> count 0)
      (when line-err-info-list
        (let* ((file       (flymake-ler-file (nth (1- count) line-err-info-list)))
               (full-file  (flymake-ler-full-file (nth (1- count) line-err-info-list)))
               (text (flymake-ler-text (nth (1- count) line-err-info-list)))
               (line       (flymake-ler-line (nth (1- count) line-err-info-list))))
          (message "[%s] %s" line text)
          )
        )
      (setq count (1- count)))))
(add-hook
 'tuareg-mode-hook
 '(lambda ()
    (if (not (null buffer-file-name)) (flymake-mode))
    (define-key tuareg-mode-map "\C-cd"
      'credmp/flymake-display-err-minibuf)))

;;==================================================
;; flymake for haskell
;;==================================================
;; (defun flymake-Haskell-init ()
;;   (flymake-simple-make-init-impl
;;    'flymake-create-temp-with-folder-structure nil nil
;;    (file-name-nondirectory buffer-file-name)
;;    'flymake-get-Haskell-cmdline))

;; (defun flymake-get-Haskell-cmdline (source base-dir)
;;   (list "ghc"
;;         (list "--make" "-fbyte-code"
;;               (concat "-i" base-dir)
;;               source)))

;; (defvar multiline-flymake-mode nil)
;; (defvar flymake-split-output-multiline nil)
;; (defadvice flymake-split-output
;;   (around flymake-split-output-multiline activate protect)
;;   (if multiline-flymake-mode
;;       (let ((flymake-split-output-multiline t))
;;         ad-do-it)
;;     ad-do-it))
;; (defadvice flymake-split-string
;;   (before flymake-split-string-multiline activate)
;;   (when flymake-split-output-multiline
;;     (ad-set-arg 1 "^\\s *$")))

;; (add-hook
;;  'haskell-mode-hook
;;  '(lambda ()
;;     (add-to-list 'flymake-allowed-file-name-masks
;;                  '("\\.l?hs$" flymake-Haskell-init flymake-simple-java-cleanup))
;;     (add-to-list 'flymake-err-line-patterns
;;                  '("^\\(.+\\.l?hs\\):\\([0-9]+\\):\\([0-9]+\\):\\(\\(?:.\\|\\W\\)+\\)"
;;                    1 2 3 4))
;;     (set (make-local-variable 'multiline-flymake-mode) t)
;;     (if (not (null buffer-file-name)) (flymake-mode))
;; ))

;; ;; display
;; (global-set-key "\C-cd" 'flymake-show-and-sit)
;; (defun flymake-show-and-sit ()
;;   "Displays the error/warning for the current-line-no line in the minibuf"
;;   (interactive)
;;   (progn
;;     (let* ((line-no (flymake-current-line-no))
;;            (line-err-info-list (nth 0 (flymake-find-err-info flymake-err-info line-no)))
;;            (count (length line-err-info-list)))
;;       (while (> count 0)
;;         (when line-err-info-list
;;           (let* ((file (flymake-ler-file (nth (1- count) line-err-info-list)))
;;                  (full-file (flymake-ler-full-file (nth (1- count) line-err-info-list)))
;;                  (text (flymake-ler-text (nth (1- count) line-err-info-list)))
;;                  (line (flymake-ler-line (nth (1- count) line-err-info-list))))
;;             (messge "[%s] %s" line text)))
;;         (setq count (1- count)))))
;;   (sit-for 60.0)
;; )

