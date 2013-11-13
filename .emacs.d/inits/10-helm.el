(require 'helm-config)

;; helm-describe-bind
(require 'helm-descbinds)
(helm-descbinds-mode)

(define-key global-map (kbd "M-x") 'helm-M-x)
(define-key global-map (kbd "C-x f") 'helm-find-files)
(define-key global-map (kbd "C-x b") 'helm-for-files)

;; hack for C-h
(eval-after-load 'helm
  '(define-key helm-map (kbd "C-h") 'delete-backward-char))
