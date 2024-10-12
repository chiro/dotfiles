;; set C-h to BackSpace
(global-set-key (kbd "C-h") 'backward-delete-char)

;; Set C-@ to set-mark-command
(global-set-key (kbd "C-@") 'set-mark-command)
(global-set-key (kbd "C-!") 'set-mark-command)
(global-set-key (kbd "C-#") 'set-mark-command)

(defalias 'yes-or-no-p 'y-or-n-p)
