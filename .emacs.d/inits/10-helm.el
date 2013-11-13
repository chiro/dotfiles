(require 'helm-config)
(helm-mode 1)

;; helm-describe-bind
(require 'helm-descbinds)
(helm-descbinds-mode)

;; helm-migemo
(require 'helm-migemo)
(setq helm-use-migemo t)

(define-key global-map (kbd "C-x b") 'helm-for-files)

;; hack for C-h
(eval-after-load 'helm
  '(define-key helm-map (kbd "C-h") 'delete-backward-char))
