(setq howm-menu-lang 'ja)

(global-set-key "\C-x,," 'howm-menu)
(setq howm-prefix "\C-x,")

(autoload 'howm-menu "howm" "Hitori Otegaru Wiki Modoki" t)

(add-hook 'howm-mode-hook
          (function (lambda () (setq outline-regexp "[*=]+")
                      (set (make-local-variable 'backup-inhibited) t))))

(add-hook 'howm-after-save-hook
          (function (lambda ()
                      (if (= (point-min) (point-max))
                          (delete-file (buffer-file-name (current-buffer)))))))

(fset 'howm-revive-todo
      (lambda (&optional arg) "Keyboard macro." (interactive "p")
        (kmacro-exec-ring-item (quote ([1 19 46 13 6 23 19 58 13 backspace 2 2] 0 "%d")) arg)))

;; org
(add-to-list 'auto-mode-alist '("howm/.+\\.howm$" . org-mode))
(add-to-list 'auto-mode-alist '("howm/.+\\.txt$" . org-mode))

(add-hook 'org-mode-hook
          (function (lambda ()
                      (if (string-match "/howm" buffer-file-name)
                          (howm-mode)))))

(require 'howm)
