;;; Shion-Valorheart-theme.el --- theme based around Shion's color palette  -*- lexical-binding: t; -*-

;; Copyright (C) 2026  Pretzels

;; Author: Pretzels <pretzels@TheExperiment>
;; Keywords: faces, games

(require 'autothemer)

(autothemer-deftheme
 Shion-Valorheart
 "A dark theme based on Shion's palette: dominant red, red/white/black outfits, sparse gold for metal, very rare cyan for gems/eyes."

 ((((class color) (min-colors 256)))

  ;; Palette — adjusted priorities
  (bg                "#000000")   ; Deeper black base for dark mode
  (bg-alt            "#0A0A0A")   ; Subtle variation for mode-line, current line
  (fg                "#D0D0D0")   ; Clean white foreground
  (fg-bright         "#E8E8E8")   ; Brighter foreground
  (fg-dim            "#C0C0C0")   ; Dimmer for less important text
  (red               "#D32F2F")   ; Strong, signature red (a bit deeper for better readability)
  (red-dim           "#B71C1C")   ; Darker red variant if needed
  (orange            "#ffae00")
  (purple            "#64349c")
  (pink              "#f973f0")
  (gold              "#E6B800")   ; Gold — used sparingly
  (yellow            "#ffd700")
  (green             "#16d102")
  (light-green       "#59fc1e")
  (baby-blue         "#82aaff")
  (blue-gem          "#00E5FF")   ; Bright cyan/blue — extremely restrained
  (dark-gray         "#424242")   ; Inactive, borders
  (bright-gray       "#757575")
  (gray              "#757575")   ; Comments, line numbers
  (highlight         "#2A2A2A")   ; Selection, subtle bg highlights

  )

 ;; Face mappings — red dominant, blue/gold minimal
 ((default                    (:background bg :foreground fg))
  (cursor                     (:background gold))
  (region                     (:background highlight :foreground fg :extend t))
  (highlight                  (:background highlight))
  (shadow                     (:foreground gray))
  (fringe                     (:background bg))
  (line-number                (:foreground gray :background bg))
  (line-number-current-line   (:foreground gold :background bg-alt :weight 'bold))  ; Gold only here for "detail"
  (mode-line                  (:background dark-gray :foreground fg :box '(:line-width 1)))
  (mode-line-highlight        (:background gold))
  (mode-line-inactive         (:background bg-alt :foreground fg-dim :box '(:line-width 1)))
  (minibuffer-prompt          (:foreground red :weight 'bold))  ; Red prompts — strong Shion feel
  (font-lock-keyword-face     (:foreground red :weight 'bold))
  (font-lock-builtin-face     (:foreground red))
  (font-lock-function-name-face (:foreground baby-blue :weight 'bold))
  (font-lock-variable-name-face (:foreground baby-blue :inherit nil))
  (font-lock-string-face      (:foreground green :slant 'italic))
  (font-lock-comment-face     (:foreground gray :slant 'italic))
  (font-lock-constant-face    (:foreground gold))
  (font-lock-type-face        (:foreground gold))
  (math-number-face           (:foreground pink))
  (math-operator-face      (:foreground orange))
  (eglot-semantic-defaultLibrary (:foreground "#128aed"))
  (eglot-highlight-symbol-face   (:foreground fg-dim))
  (error                      (:foreground red :weight 'bold :underline t))
  (success                    (:foreground blue-gem :weight 'bold))  ; Blue-gem only for success (rare positive accent)
  (warning                    (:foreground gold :weight 'bold))
  (isearch                    (:background gold :foreground bg :weight 'bold))
  (lazy-highlight             (:background highlight))
  (link                       (:foreground blue-gem :underline t))  ; Blue only for links (gem-like sparkle)
  (yas-field-highlight-face   (:background highlight :foreground red))

  ;; Doom stuff?
  (doom-modeline-battery-charging (:foreground gold :weight 'bold))
  (doom-modeline-battery-full (:foreground light-green :weight 'bold))
  (evil-goggles-default-face  (:background gold))

  ;; Vertico / Marginalia / Completion
  (vertico-current            (:background highlight :foreground fg-bright :weight 'bold))
  (vertico-match              (:foreground red))
  (completions-common-part    (:foreground red))
  (marginalia-documentation   (:foreground gray))
  (completions-annotations    (:foreground gray))

  ;; JS2-mode extras
  (js2-function-param         (:foreground fg-dim))
  (js2-external-variable      (:foreground gold))  ; Gold for globals/vars sometimes

  ;; Other accents — keep blue almost gone
  )

 ;; No post-load code needed for now
 )

;; Background transparency

(when (display-graphic-p)
  (set-frame-parameter nil 'alpha-background 80)
  (add-to-list 'default-frame-alist '(alpha-background . 80)))

(provide-theme 'Shion-Valorheart)
