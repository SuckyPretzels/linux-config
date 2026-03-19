;;; my-meow-config.el --- My meow-mode emacs config -*- lexical-binding: t; -*-

;;QoL changes
(cua-mode nil)
(setq debug-on-error t)
(setq wdired-allow-to-change-permissions t)
(setq-default display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

;; Getting rid of line numbers in certain modes
(dolist (mode '(eat-mode-hook)
	      )
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(doom-modeline-mode)
(display-battery-mode)
(setq doom-modeline-battery t)
(savehist-mode 1)
(use-package which-key
  :ensure t
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))
(require 'package)

;; Snippets
(use-package yasnippet
  :ensure t
  :config (yas-global-mode 1))

(use-package yasnippet-snippets
  :ensure t
  :after yasnippet)

;; Whenever you start to use a new language, remember to set it here 
 (use-package eglot
   :hook ((js2-mode . eglot-ensure)
          (typescript-mode . eglot-ensure)))

;; Separating tab from C-i
(define-key input-decode-map [(control ?i)] [control-i])
(define-key input-decode-map [(control ?I)] [(shift control-i)])

;; Meow setup
(defun meow-setup ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (meow-motion-define-key
   '("k" . meow-next)
   '("i" . meow-prev)
   '("<escape>" . ignore))
  (meow-leader-define-key
   ;; Use SPC (0-9) for digit arguments.
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '("/" . meow-keypad-describe-key)
   '("?" . meow-cheatsheet))
  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("a" . meow-append)
   '("A" . meow-insert)
   '("h" . meow-open-below)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("d" . meow-delete)
   '("D" . meow-backward-delete)
   '("e" . meow-next-word)
   '("E" . meow-next-symbol)
   '("f" . meow-find)
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("j" . meow-left)
   '("J" . meow-left-expand)
   '("H" . meow-open-above)
   '("k" . meow-next)
   '("K" . meow-next-expand)
   '("i" . meow-prev)
   '("I" . meow-prev-expand)
   '("o" . meow-right)
   '("O" . meow-right-expand)
   '("m" . meow-join)
   '("n" . meow-search)
   '("" . meow-block)
   '("" . meow-to-block)
   '("p" . meow-yank)
   '("q" . meow-quit)
   '("" . meow-goto-line)
   '("r" . meow-replace)
   '("R" . meow-swap-grab)
   '("s" . meow-kill)
   '("t" . meow-till)
   '("u" . meow-undo)
   '("U" . meow-undo-in-selection)
   '("/" . meow-visit)
   '("w" . meow-mark-word)
   '("W" . meow-mark-symbol)
   '("x" . meow-line)
   '("X" . meow-goto-line)
   '("y" . kill-ring-save)
   '("Y" . meow-sync-grab)
   '("z" . meow-pop-selection)
   '("'" . repeat)
   '("l" . recenter-top-bottom)
   '("<escape>" . ignore)))

(require 'meow)
(meow-setup)
(meow-global-mode 1)

(setq meow-mode-state-list
      '((eat-mode . insert))
      )

;; Key rebinds
(add-to-list 'load-path "~/.emacs.d/elpa/zoom-frm-manual/")
(require 'zoom-frm)
(global-unset-key (kbd "C--"))
(global-set-key (kbd "C-c C-c") 'eval-buffer)
(global-set-key (kbd "C--") 'zoom-in/out)
(global-set-key (kbd "C-=") 'zoom-in/out)

;; auto insert stuff
(auto-insert-mode 1)
(setq auto-insert-query nil)
(setq auto-insert-directory
      (expand-file-name "~/programming/templates/"))
(setq auto-insert-alist
      (assq-delete-all "\\.js\\'" auto-insert-alist))

;; (define-auto-insert
;;   '("\\.js\\'")
;;   "javascript-prompt-sync.js")

;; Mode replacements
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;; Setting up completion package
(use-package vertico
  :ensure t
  :init
  (vertico-mode))
(use-package marginalia
  :ensure t
  :init
  (marginalia-mode))
(use-package corfu
  :ensure t
  :config
  (global-corfu-mode))

(electric-pair-mode 1)
(setq electric-pair-pairs '(
                            (?\{ . ?\})
                            (?\( . ?\))
                            (?\[ . ?\])
                            (?\" . ?\")
                            ))
(add-hook 'js2-mode-hook
          (lambda ()
            (electric-indent-mode 1)))  ; Ensures proper indentation on newline

(setq completion-styles '(orderless basic))

;; Terminal things
(use-package eat
  :ensure t)

;; Add custom theme path
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

;; Load autothemer
(use-package autothemer
  :ensure t)

;; Add custom theme path
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

;; Load my theme
;(use-package base16-theme
;  :ensure t
;  :config
;  (load-theme 'base16-tokyo-night-moon t))

;; (load-theme 'my-tokyo-night-moon t)

(load-theme 'Shion-Valorheart :no-confirm)

;; Prevent Customize from writing to ~/.emacs
(setq custom-file (expand-file-name ".emacs.custom.el" user-emacs-directory))

;; Load the custom file if it exists
(when (file-exists-p custom-file)
  (load custom-file 'noerror 'nomessage))
