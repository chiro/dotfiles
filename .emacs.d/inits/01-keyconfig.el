;; UNDO
(global-set-key "\C-z" 'undo)

;; set C-h to BackSpace
(global-set-key "\C-h" 'backward-delete-char)

;; Set C-@ to set-mark-command
(global-set-key "\C-@" 'set-mark-command)

(defalias 'yes-or-no-p 'y-or-n-p)
