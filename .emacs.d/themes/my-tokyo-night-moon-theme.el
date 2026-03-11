
(require 'autothemer)

(autothemer-deftheme
 my-tokyo-night-moon
 "My custom version of base16-tokyo-night-moon-theme"

 ((((class color) (min-colors #xFFFFFF))) ;; only care about graphical emacs
  
  ;; define our color palette
  (black         "#000000")
  (dark-gray     "#a9a9a9")
  (white         "#ffffff")
  (white-smoke   "#f5f5f5")
  (gainsboro     "#dcdcdc"))

  ;; customize faces
 ((default                          (:foreground gainsboro))
  (font-lock-comment-face           (:foreground dark-gray))
  (font-lock-comment-delimiter-face (:foreground dark-gray))
  (font-lock-doc-face               (:foreground dark-gray))
  (shadow                           (:foreground "#6272a4"))
  (marginalia-documentation         (:foreground "#7a8db3"))))

;; transparent background
(when (display-graphic-p)
  (set-frame-parameter nil 'alpha-background 80)
  (add-to-list 'default-frame-alist '(alpha-background . 80)))

(provide-theme 'my-tokyo-night-moon)

;;; my-tokyo-night-moon-theme.el ends here


