;;; doom-quiet-light-theme.el -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Copyright (C) 2021 Matei Cotocel
;;
;; Author: Matei Cotocel <https://github.com/mcotocel>
;; Created: June 9, 2021

(require 'doom-themes)

;;; Variables

(defgroup doom-quiet-light-theme nil
  "Options for the 'doom-quiet-light' theme."
  :group 'doom-themes)

(defcustom doom-quiet-light-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-quiet-light-theme
  :type 'boolean)

(defcustom doom-quiet-light-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-quiet-light-theme
  :type 'boolean)

(defcustom doom-quiet-light-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'doom-quiet-light-theme
  :type '(choice integer boolean))

;;; Theme definition

(def-doom-theme doom-quiet-light
  "A light theme for quiet-dark"

  ((bg         '("#ffffff"))
   (fg         '("#151a1f"))

   ;; These are off-color variants of bg/fg, used primarily for `solaire-mode',
   ;; but can also be useful as a basis for subtle highlights (e.g. for hl-line
   ;; or region), especially when paired with the `doom-darken', `doom-lighten',
   ;; and `doom-blend' helper functions.
   (bg-alt     '("#fefefe"))
   (fg-alt     '("#2a343d"))

   ;; These should represent a spectrum from bg to fg, where base0 is a starker
   ;; bg and base8 is a starker fg. For example, if bg is light grey and fg is
   ;; dark grey, base0 should be white and base8 should be black.
   (base0      '("#181e23"))
   (base1      '("#181e23"))
   (base2      '("#181e23"))
   (base3      '("#181e23"))
   (base4      '("#bbbbbb"))
   (base5      '("#bbbbbb"))
   (base6      '("#bbbbbb"))
   (base7      '("#bbbbbb"))
   (base8      '("#bbbbbb"))

   (grey       base5)
   (red        '("#c74e52"))
   (orange     '("#e3595d"))
   (green      '("#3a783f"))
   (teal       '("#4c9e53"))
   (yellow     '("#ccc625"))
   (blue       '("#4663f2"))
   (dark-blue  '("#3b53cc"))
   (magenta    '("#9445cc"))
   (violet     '("#b052f2"))
   (cyan       '("#3c99a3"))
   (dark-cyan  '("#2e757d"))

   ;; These are the "universal syntax classes" that doom-themes establishes.
   ;; These *must* be included in every doom themes, or your theme will throw an
   ;; error, as they are used in the base theme defined in doom-themes-base.
   (highlight      blue)
   (vertical-bar   (doom-darken base1 0.1))
   (selection      dark-blue)
   (builtin        magenta)
   (comments       (if doom-quiet-light-brighter-comments dark-cyan base5))
   (doc-comments   (doom-lighten (if doom-quiet-light-brighter-comments dark-cyan base5) 0.25))
   (constants      violet)
   (functions      magenta)
   (keywords       blue)
   (methods        cyan)
   (operators      blue)
   (type           yellow)
   (strings        green)
   (variables      (doom-lighten magenta 0.4))
   (numbers        orange)
   (region         bg-alt)
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;; These are extra color variables used only in this theme; i.e. they aren't
   ;; mandatory for derived themes.
   (modeline-fg              fg)
   (modeline-fg-alt          base5)
   (modeline-bg              (if doom-quiet-light-brighter-modeline
                                 (doom-darken blue 0.45)
                               (doom-darken bg-alt 0.1)))
   (modeline-bg-alt          (if doom-quiet-light-brighter-modeline
                                 (doom-darken blue 0.475)
                               `(,(doom-darken (car bg-alt) 0.15) ,@(cdr bg))))
   (modeline-bg-inactive     `(,(car bg-alt) ,@(cdr base1)))
   (modeline-bg-inactive-alt `(,(doom-darken (car bg-alt) 0.1) ,@(cdr bg)))

   (-modeline-pad
    (when doom-quiet-light-padded-modeline
      (if (integerp doom-quiet-light-padded-modeline) doom-quiet-light-padded-modeline 4))))


  ;;;; Base theme face overrides
  (((line-number &override) :foreground base4)
   ((line-number-current-line &override) :foreground fg)
   ((font-lock-comment-face &override)
    :background (if doom-quiet-light-brighter-comments (doom-lighten bg 0.05)))
   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis :foreground (if doom-quiet-light-brighter-modeline base8 highlight))

   ;;;; css-mode <built-in> / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)
   ;;;; doom-modeline
   (doom-modeline-bar :background (if doom-quiet-light-brighter-modeline modeline-bg highlight))
   (doom-modeline-buffer-file :inherit 'mode-line-buffer-id :weight 'bold)
   (doom-modeline-buffer-path :inherit 'mode-line-emphasis :weight 'bold)
   (doom-modeline-buffer-project-root :foreground green :weight 'bold)
   ;;;; elscreen
   (elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")
   ;;;; ivy
   (ivy-current-match :background bg :distant-foreground blue :weight 'bold)
   ;;;; LaTeX-mode
   (font-latex-math-face :foreground green)
   ;;;; markdown-mode
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'bold :foreground red)
   ((markdown-code-face &override) :background (doom-lighten base3 0.05))
   ;;;; rjsx-mode
   (rjsx-tag :foreground red)
   (rjsx-attr :foreground orange)
   ;;;; org-mode
   ((org-block &override) :background bg-alt)
   ((org-block-begin-line &override) :foreground base5)
   ;;;; solaire-mode
   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-alt)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-alt))))

  ;;;; Base theme variable overrides-
  ())

;;; doom-quiet-light-theme.el ends hereo
