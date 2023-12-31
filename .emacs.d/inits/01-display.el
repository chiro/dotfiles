
;; 文字の色つけ
(global-font-lock-mode t)

;; 日本語infoの文字化け防止
(auto-compression-mode t)

;; 時計
(display-time)

;; 警告音を消す
(setq visible-bell t)

;; display column number
(column-number-mode t)

;; 対応する括弧を光らせる
(show-paren-mode t)

;; regionに色をつける
(setq transient-mark-mode t)

;; 左に行番号を表示
(setq-default display-line-numbers t)
(set-face-foreground 'line-number "#800")
(set-face-foreground 'line-number-current-line "#080")

;; 行末の空白を強調表示
(setq-default show-trailing-whitespace t)
(set-face-background 'trailing-whitespace "#b14770")

(setq-default line-spacing 0)

;; No tool bar
(tool-bar-mode 0)
;; No menu bar
(menu-bar-mode 0)

(when (window-system)
  (setq frame-title-format
        (concat "%b - emacs@" system-name))

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
  (setq hl-line-face 'hlline-face)
  (global-hl-line-mode)

  (setq default-frame-alist
        (append (list
                 '(left . 1000)
                 '(width . 142)
                 '(height . 74))
                default-frame-alist))
) ;; end (when (window-system))
