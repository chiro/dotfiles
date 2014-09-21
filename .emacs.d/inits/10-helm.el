(require 'helm-config)

;; helm-describe-bind
(require 'helm-descbinds)
(helm-descbinds-mode)

(define-key global-map (kbd "M-x") 'helm-M-x)
(define-key global-map (kbd "C-x f") 'helm-for-files)

;; hack for C-h
(eval-after-load 'helm
  '(define-key helm-map (kbd "C-h") 'delete-backward-char))

;; helm-ghq
(require 'helm-ghq)

(require 'helm-files)
(defadvice helm-for-files
    (around helm-for-files-no-highlight activate)
  (let ((helm-mp-highlight-delay nil))
    ad-do-it))

(defconst helm-for-files-preferred-list
  '(helm-source-buffers-list
    helm-source-recentf
    helm-source-file-cache
    helm-source-ghq
    helm-source-files-in-current-dir
    ))
