
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
(global-linum-mode t)
(set-face-attribute 'linum nil
                    :foreground "#800"
                    :height 0.9)
(setq linum-format "%4d")

;; 行末の空白を強調表示
(setq-default show-trailing-whitespace t)
(set-face-background 'trailing-whitespace "#b14770")

(setq-default line-spacing 0)

(when (window-system)
  (setq frame-title-format
        (concat "%b - emacs@" system-name))

  ;; Hide scroll bar
  (set-scroll-bar-mode nil)

  (set-face-attribute 'default nil
                      :family "Ricty"
                      :height 120)
  (set-fontset-font nil 'japanese-jisx0208 (font-spec :family "Ricty"))

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
) ;; end (when (window-system)
