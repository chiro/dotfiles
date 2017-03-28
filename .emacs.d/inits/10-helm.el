(defadvice helm-for-files
    (around helm-for-files-no-highlight activate)
  (let ((helm-mp-highlight-delay nil))
    ad-do-it))

(defconst helm-for-files-preferred-list
  '(helm-source-buffers-list
    helm-source-recentf
    helm-source-file-cache
    helm-source-files-in-current-dir
    ))

(use-package helm
  :defer 1
  :bind (("M-x" . helm-M-x)
         ("C-x f" . helm-for-files)
         :map helm-map
         ("C-h" . delete-backword-char)
         ;; :map helm-find-files-map
         ;; ("C-h" . delete-backword-char))
         )
  :config
  (use-package helm-descbinds
    :ensure t
    :config (helm-descbinds-mode)))
