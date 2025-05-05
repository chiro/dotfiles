;; 文字の色つけ
(global-font-lock-mode t)

;; 警告音を消す
(setopt visible-bell t)

;; display column number
(setopt line-number-mode t)
(setopt column-number-mode t)

;; 対応する括弧を光らせる
(show-paren-mode t)

;; regionに色をつける
(setopt transient-mark-mode t)

;; 左に行番号を表示
(setopt display-line-numbers t)
(set-face-foreground 'line-number "#800")
(set-face-foreground 'line-number-current-line "#080")

;; 行末の空白を強調表示
(setopt show-trailing-whitespace t)
(set-face-background 'trailing-whitespace "#b14770")

;; No tool bar
(tool-bar-mode 0)
;; No menu bar
(menu-bar-mode 0)

(when (window-system)
  ;; Hide scroll bar
  (set-scroll-bar-mode nil)

  (set-face-attribute 'default nil
                      :family "Hack"
                      :height 80)
  (set-fontset-font nil 'japanese-jisx0208 (font-spec :family "Hack"))

  ;; カーソル行をハイライト
  (defface hlline-face
    '((((class color)
        (background dark))
       (:background "dark slate gray"))
      (((class color)
        (background light))
       (:background "Gray"))
      (t
       ()))
    "*Face used by hl-line.")
  (setopt hl-line-face 'hlline-face)
  (global-hl-line-mode)
) ;; end (when (window-system))
