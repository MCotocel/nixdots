;;; doom-quiet-dark-theme.el -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Copyright (C) 2021 Matei Cotocel
;;
;; Author: Matei Cotocel <https://github.com/mcotocel>
;; Created: June 9, 2021

(require 'doom-themes)

;;; Variables

(defgroup doom-quiet-dark-theme nil
  "Options for the 'doom-quiet-dark' theme."
  :group 'doom-themes)

(defcustom doom-quiet-dark-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-quiet-dark-theme
  :type 'boolean)

(defcustom doom-quiet-dark-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-quiet-dark-theme
  :type 'boolean)

(defcustom doom-quiet-dark-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'doom-quiet-dark-theme
  :type '(choice integer boolean))

;;; Theme definition

(def-doom-theme doom-quiet-dark
  "A dark theme partially inspired by Atom One Dark"

  ((bg         '("#181e23"))
   (fg         '("#D5D5D5"))

   ;; These are off-color variants of bg/fg, used primarily for `solaire-mode',
   ;; but can also be useful as a basis for subtle highlights (e.g. for hl-line
   ;; or region), especially when paired with the `doom-darken', `doom-lighten',
   ;; and `doom-blend' helper functions.
   (bg-alt     '("#1f252a"))
   (fg-alt     '("#cacaca"))

   ;; These should represent a spectrum from bg to fg, where base0 is a starker
   ;; bg and base8 is a starker fg. For example, if bg is light grey and fg is
   ;; dark grey, base0 should be white and base8 should be black.
   (base0      '("#181e23"))
   (base1      '("#181e23"))
   (base2      '("#181e23"))
   (base3      '("#181e23"))
   (base4      '("#384149"))
   (base5      '("#384149"))
   (base6      '("#384149"))
   (base7      '("#384149"))
   (base8      '("#384149"))

   (grey       base5)
   (red        '("#FF8080"))
   (orange     '("#FFAEAE"))
   (green      '("#97D59B"))
   (teal       '("#BEF8C1"))
   (yellow     '("#FFFE80"))
   (blue       '("#ACE1FF"))
   (dark-blue  '("#80D1FF"))
   (magenta    '("#C780FF"))
   (violet     '("#D8A8FF"))
   (cyan       '("#A2FFEB"))
   (dark-cyan  '("#80FFE4"))

   ;; These are the "universal syntax classes" that doom-themes establishes.
   ;; These *must* be included in every doom themes, or your theme will throw an
   ;; error, as they are used in the base theme defined in doom-themes-base.
   (highlight      blue)
   (vertical-bar   (doom-darken base1 0.1))
   (selection      base4)
   (builtin        magenta)
   (comments       (if doom-quiet-dark-brighter-comments dark-cyan base5))
   (doc-comments   (doom-lighten (if doom-quiet-dark-brighter-comments dark-cyan base5) 0.25))
   (constants      violet)
   (functions      magenta)
   (keywords       blue)
   (methods        cyan)
   (operators      blue)
   (type           yellow)
   (strings        green)
   (variables      (doom-lighten magenta 0.4))
   (numbers        orange)
   (region         `(,(doom-lighten (car bg-alt) 0.15) ,@(doom-lighten (cdr base1) 0.35)))
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
   (modeline-bg              (if doom-quiet-dark-brighter-modeline
                                 (doom-darken blue 0.45)
                               (doom-darken bg-alt 0.1)))
   (modeline-bg-alt          (if doom-quiet-dark-brighter-modeline
                                 (doom-darken blue 0.475)
                               `(,(doom-darken (car bg-alt) 0.15) ,@(cdr bg))))
   (modeline-bg-inactive     `(,(car bg-alt) ,@(cdr base1)))
   (modeline-bg-inactive-alt `(,(doom-darken (car bg-alt) 0.1) ,@(cdr bg)))

   (-modeline-pad
    (when doom-quiet-dark-padded-modeline
      (if (integerp doom-quiet-dark-padded-modeline) doom-quiet-dark-padded-modeline 4))))


  ;;;; Base theme face overrides
  (((line-number &override) :foreground base4)
   ((line-number-current-line &override) :foreground fg)
   ((font-lock-comment-face &override)
    :background (if doom-quiet-dark-brighter-comments (doom-lighten bg 0.05)))
   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis :foreground (if doom-quiet-dark-brighter-modeline base8 highlight))

   ;;;; css-mode <built-in> / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)
   ;;;; doom-modeline
   (doom-modeline-bar :background (if doom-quiet-dark-brighter-modeline modeline-bg highlight))
   (doom-modeline-buffer-file :inherit 'mode-line-buffer-id :weight 'bold)
   (doom-modeline-buffer-path :inherit 'mode-line-emphasis :weight 'bold)
   (doom-modeline-buffer-project-root :foreground green :weight 'bold)
   ;;;; elscreen
   (elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")
   ;;;; ivy
   (ivy-current-match :background grey :distant-foreground blue :weight 'bold)
   ;;;; LaTeX-mode
   (font-latex-math-face :foreground green)
   ;;;; markdown-mode
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'bold :foreground red)
   ((markdown-code-face &override) :background (doom-lighten base3 0.05))
   ;;;; rjsx-mode
   (rjsx-tag :foreground red)
   (rjsx-attr :foreground orange)
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

;;; doom-quiet-dark-theme.el ends hereo
