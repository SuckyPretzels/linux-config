(setq debug-on-error t)

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
(global-set-key (kbd "C-c C-c") 'eval-buffer)
(global-unset-key (kbd "C-,"))
(global-unset-key (kbd "C-/"))
(global-set-key (kbd "C-/") 'kill-whole-line)
(global-set-key (kbd "C-,") 'backward-kill-sentence)
(global-set-key (kbd "C-.") 'kill-line)
(global-unset-key (kbd "C--"))
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-=") 'text-scale-increase)

;;auto insert stuff
(auto-insert-mode 1)
(setq auto-insert-query nil)
(setq auto-insert-directory
      (expand-file-name "~/programming/templates/"))
(define-auto-insert
  '("\\.js\\'" . "JavaScript with prompt-sync")
  "javascript-prompt-sync.js")

;; QoL changes
(cua-mode t)
(global-display-line-numbers-mode)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(add-to-list 'default-frame-alist '(font . "RecMonoCasual Nerd Font"))

;; Add custom theme path
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

;; Load autothemer
(use-package autothemer
  :ensure t)

;; Load my theme
(use-package base16-theme
  :ensure t
  :config
  (load-theme 'base16-tokyo-night-moon t))

(load-theme 'my-tokyo-night-moon t)

;; Prevent Customize from writing to ~/.emacs
(setq custom-file (expand-file-name ".emacs.custom.el" user-emacs-directory))

;; Load the custom file if it exists
(when (file-exists-p custom-file)
  (load custom-file 'noerror 'nomessage))

