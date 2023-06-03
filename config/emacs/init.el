;;;; init.el ---- My Emacs config
;;;; Commentary:
;;;; It's pretty messy, not the greatest, but it works for me
;;;; Code:

;; A few settings
(setq-default
  delete-by-moving-to-trash t ;; Move to trash instead of deleting
  require-final-newline t ;; Auto create a newline at end of file
  custom-safe-themes t ;; Don't ask if theme is safe
  warning-minimum-level :emergency ;; Emacs, honestly, if there's an error in my configuration, I'll find out soon enough
  disabled-command-function nil ;; Yes I want to use that command
  vc-follow-symlinks) ;; Follow those symlinks!

(defalias 'yes-or-no-p 'y-or-n-p) ;; Y or N instead of yes or no

;; Scroll settings
(setq scroll-margin 1
  scroll-step 1
  scroll-conservatively 10000)

;; Set up Melpa and use-package
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t ;; Always make sure that packages are installed
      straight-use-package-by-default t) ;; Use straight for every use-package declaration

;; Bootstrap straight
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(setq package-enable-at-startup nil)

;; Git settings
(when (equal ""
             (shell-command-to-string "git config user.name"))
  (shell-command "git config --global user.name \"Matei Cotocel\"")
  (shell-command "git config --global user.email \"mcotocel@outlook.com\""))

;; Simplify the UI
(menu-bar-mode -1) ;; Disable the menu bar, I have shortcuts
(scroll-bar-mode -1) ;; Disable the scroll bar, it looks ok but the background isn't transparent and I have a minimap anyway
(tool-bar-mode -1) ;; Disable the tool bar, it's plain ugly
(setq inhibit-splash-screen nil ;; I have a nicer one
      inhibit-startup-echo-area-message t ;; Make the startup a little cleaner
      server-client-instructions nil ;; Hide the client message
      inhibit-startup-message t) ;; No messages on startup
(setq ring-bell-function 'ignore) ;; Disable the bell

;; Font settings
(add-to-list 'default-frame-alist '(font . "Iosevka Nerd Font-12")) ;; I like Iosevka, it's a nice font
(set-fontset-font t 'emoji (font-spec :family "Twitter Color Emoji") nil 'prepend) ;; Some decent looking emojis
(use-package ligature
  :config
  (ligature-set-ligatures 't '("www"))
  (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
  :config
  ;; Iosevka ligatures
  (ligature-set-ligatures 'prog-mode '("<---" "<--"  "<<-" "<-" "->" "-->" "--->" "<->" "<-->" "<--->" "<---->" "<!--"
                                       "<==" "<===" "<=" "=>" "=>>" "==>" "===>" ">=" "<=>" "<==>" "<===>" "<====>" "<!---"
                                       "<~~" "<~" "~>" "~~>" "::" ":::" "==" "!=" "===" "!=="
                                       ":=" ":-" ":+" "<*" "<*>" "*>" "<|" "<|>" "|>" "+:" "-:" "=:" "<******>" "++" "+++"))
  (global-ligature-mode t))

;; Change some text to symbols
(defun org/prettify-set ()
    (interactive)
    (setq prettify-symbols-alist
        '(("#+begin_src" . "")
          ("#+end_src" . "")
          ("#+begin_example" . "")
          ("#+end_example" . "")
          ("#+results:" . "")
          ("#+begin_quote" . "")
          ("#+end_quote" . "")
          ("[ ]" . "")
          ("[-]" . "")
          ("[X]" . ""))))
  (add-hook 'org-mode-hook 'org/prettify-set)
(defun prog/prettify-set ()
    (interactive)
    (setq prettify-symbols-alist
        '(("delta" . "Δ")
          ("lambda" . "λ"))))
  (add-hook 'prog-mode-hook 'prog/prettify-set)
(global-prettify-symbols-mode)

;; Line numbers
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative) ;; Set it to relative, it makes for easier maths
(dolist (mode '(org-mode-hook
  term-mode-hook
  dashboard-mode-hook
  eshell-mode-hook
  neotree-mode-hook
  elfeed-show-mode-hook
  doc-view-mode-hook
  xwidget-webkit-mode-hook
  woman-mode-hook))
(add-hook mode (lambda () (display-line-numbers-mode 0)))) ;; Some modes are better with no line numbers

;; File locations
(setq recentf-save-file "~/.config/emacs/etc/recentf" ;; File for recentf
      recentf-max-saved-items 50)
(setq savehist-file "~/.config/emacs/etc/savehist" ;; File for save history
      history-length 150)
(setq save-place-file "~/.config/emacs/etc/saveplace") ;; File for save location
(setq bookmark-default-file "~/.config/emacs/etc/bookmarks") ;; File for bookmarks
(setq backup-directory-alist '(("." . "~/.config/emacs/backups")) ;; Directory for backups
      delete-old-versions t
      kept-old-versions 20
      vc-make-backup-files t
      version-control t)
(setq custom-file "~/.config/emacs/etc/custom.el") ;; For saved customizations
(setq create-lockfiles nil) ;; Disable lockfiles
(save-place-mode) ;; Save location
(add-function :after after-focus-change-function (lambda () (save-some-buffers t))) ;; Save buffer when focus is lost
(global-visual-line-mode) ;; Wrap lines
(global-auto-revert-mode) ;; Revert buffers
(recentf-mode) ;; Recent files
(add-hook 'org-mode-hook 'flyspell-mode) ;; Spell checker

;; Indentation
(setq-default indent-tabs-mode nil
    tab-width 4)
(setq indent-line-function 'insert-tab) ;; Convert tabs to spaces

;; Vim keybinds
(use-package evil ;; Let's install a proper text editor on top of this OS
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-org
  :after org
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

;; Leader keys are so much better
(use-package evil-leader
  :config
  (global-evil-leader-mode)
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
    ;; General
    ".f" 'consult-line
    ".q" 'delete-frame
    ".e" 'eval-region
    ".s" 'straight-use-package
    "SPC" 'execute-extended-command
    ;; Undo
    "uv" 'undo-tree-visualize
    "uu" 'undo-tree-undo
    "ur" 'undo-tree-redo
    "uc" 'consult-yank-pop
    ;; Dictionaries
    "dt" 'mw-thesaurus-lookup-dwim
    "dd" 'dictionary-lookup-definition
    "dr" 'gts-do-translate
    ;; Files
    "fr" 'consult-recent-file
    "fb" 'consult-bookmark
    "ff" 'find-file
    ;; Bufffers and windows
    "bv" 'split-window-right
    "bh" 'split-window-below
    "bd" 'kill-current-buffer
    "bw" 'quit-window
    "bb" 'consult-buffer
    "bx" 'switch-to-scratch
    "be" 'emacs-everywhere-finish
    ;; Projectile
    "pa" 'projectile-add-known-project
    "pf" 'consult-projectile
    "pp" 'projectile-switch-project
    "pg" 'projectile-grep
    "pm" 'projectile-commander
    "pc" 'projectile-compile-project
    ;; Workspaces
    "ws" 'persp-switch
    "wd" 'persp-kill
    "wr" 'persp-rename
    ;; Help
    "hh" 'help
    "hk" 'describe-key
    "hv" 'describe-variable
    "hf" 'describe-function
    "hs" 'describe-symbol
    "hm" 'describe-mode
    ;; Emojis
    "ei" 'emoji-insert
    "es" 'emoji-search
    ;; Magit
    "gi" 'magit-init
    "gc" 'magit-commit
    "gp" 'magit-push
    "gC" 'magit-clone
    "gs" 'magit-status))

;; A few extra keybinds
(define-key evil-normal-state-map (kbd "M-s") 'save-buffer)
(define-key evil-normal-state-map (kbd "M-w") 'delete-window)
(define-key evil-normal-state-map (kbd "M-q") 'kill-current-buffer)

(define-key evil-normal-state-map (kbd "<C-tab>") 'consult-buffer)

(define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
(define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
(define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
(define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)
(define-key evil-normal-state-map (kbd "M-j") 'evil-scroll-down)
(define-key evil-normal-state-map (kbd "M-k") 'evil-scroll-up)

(define-key evil-normal-state-map "u" 'undo-tree-undo)
(define-key evil-normal-state-map (kbd "C-r") 'undo-tree-redo)

(define-key evil-normal-state-map (kbd "M-t") 'neotree-toggle)
(define-key evil-normal-state-map (kbd "M-m") 'minimap-mode)
(define-key evil-normal-state-map (kbd "<C-return>") 'shr-browse-url)
(define-key key-translation-map (kbd "ESC") (kbd "C-g"))

(define-key evil-normal-state-map (kbd "C-=") 'text-scale-increase)
(define-key evil-normal-state-map (kbd "C--") 'text-scale-decrease)
(define-key evil-normal-state-map (kbd "C-0") 'text-scale-adjust)

(define-key evil-normal-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)

;; Cursor colours and types
(set-default 'evil-normal-state-cursor 'hbar)
(set-default 'evil-insert-state-cursor 'bar)
(set-default 'evil-visual-state-cursor 'hbar)
(set-default 'evil-motion-state-cursor 'box)
(set-default 'evil-replace-state-cursor 'box)
(set-default 'evil-operator-state-cursor 'hbar)
(set-cursor-color "#80D1FF")
(setq-default cursor-type 'bar)

;; Bring some Emacs to Evil
(setq evil-cross-lines t
      evil-move-beyond-eol t
      evil-symbol-word-search t
      evil-want-Y-yank-to-eol t
      evil-cross-lines t)

;; In case I forget some keybinds
(use-package which-key
  :config (which-key-mode)
  (which-key-setup-side-window-bottom)
  (setq which-key-idle-delay 0.1))

;; M-x but better
(use-package consult)

;; For projectile navigation
(use-package consult-projectile
  :straight (consult-projectile :type git :host gitlab :repo "OlMon/consult-projectile" :branch "master"))

;; Better completion
(use-package vertico
  :init (vertico-mode 1)
  :config
  (setq vertico-resize nil
        vertico-count 14
        vertico-cycle t))

;; Match in any order
(use-package orderless
  :init
  (setq completion-styles '(orderless)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

;; Stuff on margins
(use-package marginalia
  :init (marginalia-mode))

;; A nicer startup dashboard
(use-package dashboard)

(dashboard-setup-startup-hook)

(setq dashboard-center-content t
  dashboard-show-shortcuts nil
  dashboard-startup-banner "~/.config/emacs/banner.txt"
  dashboard-set-heading-icons t
  dashboard-set-file-icons t
  dashboard-set-navigator t
  dashboard-items 'nil
  dashboard-init-info (format "Startup took around %ss" (round (string-to-number (emacs-init-time))))
  dashboard-set-footer 'nil)

(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
(add-hook 'neo-after-create-hook (lambda (&optional dummy) (setq mode-line-format nil)))
(add-hook 'dashboard-after-initialize-hook (lambda (&optional dummy) (setq mode-line-format nil)))

(use-package neotree)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(add-hook 'neotree-mode-hook
         (lambda ()
           (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-quick-look)
           (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)
           (define-key evil-normal-state-local-map (kbd "g") 'neotree-refresh)
           (define-key evil-normal-state-local-map (kbd "A") 'neotree-stretch-toggle)
           (define-key evil-normal-state-local-map (kbd "H") 'neotree-hidden-file-toggle)))
(setq neo-window-fixed-size nil
      neo-window-width 35
      neo-hide-cursor t
      projectile-switch-project-action 'neotree-projectile-action
      neo-smart-open t)

(use-package magit
  :defer t)

(use-package smartparens
  :init (smartparens-global-mode)
  (show-smartparens-mode))

(use-package highlight-indent-guides
  :init (highlight-indent-guides-mode t))
(setq highlight-indent-guides-method 'character)

(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

;; Kmonad support
(use-package kbd-mode
  :straight (kbd-mode :type git :host github :repo "kmonad/kbd-mode" :branch "master"))

(use-package all-the-icons)

(use-package doom-modeline
  :init
  (doom-modeline-mode 1)
  (setq doom-modeline-height 35
    doom-modeline-bar-width 2
    doom-modeline-buffer-encoding 'nondefault
    doom-modeline-major-mode-icon t
    doom-modeline-icon t))

(custom-set-faces
 '(mode-line ((t (:family "Iosevka Nerd Font" :height 120)))))

(use-package minimap
  :config
  (setq minimap-window-location 'right
        minimap-update-delay 0
        minimap-width-fraction 0.1
        minimap-minimum-width 10
        minimap-major-modes '(text-mode prog-mode))
  :init (minimap-mode 0))

(use-package undo-tree
  :config
  (global-undo-tree-mode))
  (setq undo-tree-auto-save-history t)
  (setq undo-tree-history-directory-alist '(("." . "~/.config/emacs/undo")))

(use-package format-all
  :init (format-all-mode))

(use-package doom-themes
  :config
  (load-theme 'doom-quiet-dark t)
  (doom-themes-neotree-config))

(use-package elfeed)
(setq elfeed-feeds
       '(("https://planet.emacslife.com/atom.xml" emacs)
         ("https://kotaku.com/rss" gaming)))
(evil-define-key 'normal elfeed-search-mode-map (kbd "r") 'elfeed-search-untag-all-unread)
(evil-define-key 'normal elfeed-search-mode-map (kbd "u") 'elfeed-update)

(use-package lsp-mode
  :init
  :hook ((python-mode . lsp)
         (sh-mode . lsp)
         (css-mode . lsp)
         (html-mode . lsp)
         (json-mode . lsp)
         (latex-mode . lsp)
         (nix-mode . lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp
  :config
  (setq lsp-enable-symbol-highlighting nil
      lsp-ui-doc-enable t
      lsp-lens-enable nil
      lsp-headerline-breadcrumb-enable nil
      lsp-ui-sideline-enable nil
      lsp-ui-sideline-enable t
      lsp-modeline-code-actions-enable t
      lsp-ui-sideline-enable t
      lsp-ui-doc-border nil
      lsp-eldoc-enable-hover t
      lsp-log-io nil
      lsp-enable-file-watchers nil))

(use-package lsp-ui :commands lsp-ui-mode)

(setq lsp-enable-symbol-highlighting nil)

(use-package json-mode)
(use-package lua-mode)
(use-package nix-mode)
(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))

(use-package tree-sitter)
(use-package tree-sitter-langs)
(global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

(use-package corfu
  :config
  (setq corfu-cycle t
    corfu-auto t
    corfu-auto-delay 0
    corfu-auto-prefix 1
    corfu-preselect 'first
    corfu-preview-current t
    corfu-count 5
    corfu-max-width 40
    corfu-min-width 40
    corfu-bar-width 1
    corfu-scroll-margin 5)
  :bind
    (:map corfu-map
        ("TAB" . corfu-next)
        ("S-TAB" . corfu-previous)
        ("<escape>" . corfu-reset)
        ("<right>" . corfu-complete))
  :init
  (global-corfu-mode))

(load-file "~/.config/emacs/straight/repos/corfu/extensions/corfu-popupinfo.el")
(corfu-popupinfo-mode)
(setq corfu-popupinfo-delay 0)

(use-package kind-icon
  :ensure t
  :after corfu
  :custom
  (kind-icon-default-face 'corfu-default)
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(use-package yasnippet
  :hook (prog-mode . yas-global-mode))

(use-package yasnippet-snippets
  :defer t)

(use-package realgud)

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package projectile
  :config (projectile-mode 1))

(use-package perspective
  :init
  (persp-mode))

(setq persp-state-default-file "~/.config/emacs/pesrp-save.el")
(add-hook 'kill-emacs-hook #'persp-state-save)

(use-package dictionary)

(use-package mw-thesaurus)

(use-package go-translate)

(setq gts-translate-list '(("en" "ro") ("ro" "en")))

(setq gts-default-translator
      (gts-translator
       :picker (gts-prompt-picker)
       :engines (gts-google-engine)
       :render (gts-buffer-render)))

(use-package org-contrib)

(use-package org-download)

(setq org-export-backends '(latex md html man))

(require 'org)
(require 'ox-latex)
(require 'ox-man)
(require 'ox-publish)

(setq org-publish-use-timestamps-flag nil
    org-export-with-toc nil
    org-export-with-broken-links t)

(add-to-list 'org-latex-packages-alist '("" "minted"))
(setq org-latex-src-block-backend 'minted)

(use-package htmlize)

(setq org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

(setq org-src-fontify-natively t)

(setq org-export-with-section-numbers nil)

(setq org-html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"./style.css\"/>"
  org-html-doctype "html5")

(use-package org-bullets
  :after org
  :hook
  (org-mode . (lambda () (org-bullets-mode 1))))

(setq org-hide-emphasis-markers t
    org-image-actual-width '(300)
    org-agenda-start-on-weekday 0
    org-src-tab-acts-natively t
    org-startup-with-inline-images t)
(set-face-attribute 'org-headline-done nil :strike-through t)

(use-package emacs-everywhere) ;; Why would you leave Emacs?

(use-package all-the-icons-dired
  :hook dired-mode all-the-icons-dired)

(defun edit-file-root ()
  "Use tramp to edit the current buffer as root."
  (interactive)
  (when buffer-file-name
    (find-alternate-file
     (concat "/sudo:root@localhost:"
             buffer-file-name))))

(defun switch-to-scratch ()
  "Switch to the scratch buffer."
  (interactive)
  (switch-to-buffer "*scratch*"))

(provide 'init)
;; Local Variables:
;; flycheck-disabled-checkers: (emacs-lisp-checkdoc)
;; byte-compile-warnings: (not free-vars unresolved)
;; End:
