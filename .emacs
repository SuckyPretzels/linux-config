(setq debug-on-error t)
(setq wdired-allow-to-change-permissions t)

;; QoL changes
(cua-mode t)
(setq-default display-line-numbers-type 'relative)
(global-display-line-numbers-mode)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(add-to-list 'default-frame-alist '(font . "RecMonoCasual Nerd Font"))
(savehist-mode 1)

;; Snippets
(use-package yasnippet
  :ensure t
  :config (yas-global-mode 1))

(use-package yasnippet-snippets
  :ensure t
  :after yasnippet)

;; Option B: eglot (lighter, built-in since Emacs 29)
 (use-package eglot
   :hook ((js2-mode . eglot-ensure)
          (typescript-mode . eglot-ensure)))

;; Separating tab from C-i
(define-key input-decode-map [(control ?i)] [control-i])
(define-key input-decode-map [(control ?I)] [(shift control-i)])
(global-set-key [control-i] 'backward-paragraph)
 
;; Define a minor mode for "arrow mode" where i j k o act as arrows
(define-minor-mode arrow-mode
  "Minor mode where i j k o behave like arrow keys (up left down right)."
  :lighter " Arrow"
  :keymap (let ((map (make-sparse-keymap)))
	    (define-key map (kbd "C-i") nil)
            ;; i = up, j = left, k = down, o = right
            (define-key map (kbd "i") 'previous-line)
            (define-key map (kbd "j") 'backward-char)
            (define-key map (kbd "k") 'next-line)
            (define-key map (kbd "o") 'forward-char)
	    (define-key map (kbd "I") 'previous-line)
            (define-key map (kbd "J") 'backward-char)
            (define-key map (kbd "K") 'next-line)
            (define-key map (kbd "O") 'forward-char)
	    ;; C- behavior
	    (define-key map (kbd "C-j") 'backward-word)
	    (define-key map (kbd "C-k") 'forward-paragraph)
	    (define-key map (kbd "C-o") 'forward-word)
	    ;; M- as replacement for fn behavior
	    (define-key map (kbd "M-i") 'scroll-down-command)
	    (define-key map (kbd "M-j") 'beginning-of-line)
	    (define-key map (kbd "M-k") 'scroll-up-command)
	    (define-key map (kbd "M-o") 'end-of-line)
	    ;; TAB behavior 
	    
            map))

;; Globalized arrow-mode (affects all normal buffers, skips minibuffer)
(define-globalized-minor-mode global-arrow-mode
  arrow-mode
  (lambda ()
    (unless (minibufferp)
      (arrow-mode 1))))

(global-set-key (kbd "C-M-SPC") 'global-arrow-mode)

(defun my-arrow-minibuffer-setup()
  (arrow-mode -1)
  (local-set-key (kbd "C-M-SPC") 'arrow-mode))

(add-hook 'minibuffer-setup-hook #'my-arrow-minibuffer-setup)

(defun my-arrow-vterm-setup()
  (arrow-mode -1)
  (local-set-key (kbd "C-M-SPC") 'arrow-mode))

(add-hook 'vterm-mode-hook #'my-arrow-vterm-setup)

;; Key rebinds
(add-to-list 'load-path "~/.emacs.d/elpa/zoom-frm-manual/")
(require 'zoom-frm)
(global-unset-key (kbd "C-,"))
(global-unset-key (kbd "C-/"))
(global-unset-key (kbd "C--"))
(global-unset-key (kbd "C-a"))
(global-unset-key (kbd "C-f"))
(global-set-key (kbd "C-c C-c") 'eval-buffer)
(global-set-key (kbd "C-/") 'kill-whole-line)
(global-set-key (kbd "C-,") 'backward-kill-sentence)
(global-set-key (kbd "C-.") 'kill-line)
(global-set-key (kbd "C--") 'zoom-in/out)
(global-set-key (kbd "C-=") 'zoom-in/out)
(global-set-key (kbd "C-a") 'mark-whole-buffer)
(global-set-key (kbd "C-f") 'isearch-forward)
(define-key isearch-mode-map (kbd "C-f") 'isearch-repeat-forward)

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

;; Add custom theme path
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

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
            (define-key js2-mode-map "{" #'electric-pair-open-newline-between-pairs-sun)
            (electric-indent-mode 1)))  ; Ensures proper indentation on newline

(setq completion-styles '(orderless basic))

;; Vterm things
(use-package vterm
  :ensure t
  :config
  (setq vterm-max-scrollback 10000)
  (setq vterm-timer-delay 0.01))

;; Load autothemer
(use-package autothemer
  :ensure t)

;; Load my theme
;(use-package base16-theme
;  :ensure t
;  :config
;  (load-theme 'base16-tokyo-night-moon t))

;; (load-theme 'my-tokyo-night-moon t)

(load-theme 'Shion-Valorheart)

;; Prevent Customize from writing to ~/.emacs
(setq custom-file (expand-file-name ".emacs.custom.el" user-emacs-directory))

;; Load the custom file if it exists
(when (file-exists-p custom-file)
  (load custom-file 'noerror 'nomessage))

