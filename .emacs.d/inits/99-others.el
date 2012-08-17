; バッファのbyte数を数える
(defun count-size-buffer ()
  (interactive)
  (let (bufStr)
    (setq bufStr (buffer-substring-no-properties (point-min) (point-max)))
    (message
     (concat (number-to-string (length bufStr)) "byte(s)"))))
