(add-hook
 'skk-load-hook
 (lambda ()
   (require 'context-skk)
   (setq skk-rom-kana-rule-list
         (nconc skk-rom-kana-rule-list
                '((";" nil nil)
                  (":" nil nil)
                  ("?" nil nil)
                  ("!" nil nil))))))

(require 'skk-autoloads)
(require 'skk)
(setq skk-auto-insert-paren t)
