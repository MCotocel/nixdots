(load-file "~/.config/emacs/etc/private.el")
(add-to-list 'load-path "~/.config/emacs/lisp/")
(setq warning-minimum-level :emergency)
(setq auto-window-vscroll nil)
(setq frame-resize-pixelwise t)

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

(setq use-package-always-ensure t)
(setq straight-use-package-by-default t)

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

(use-package auto-package-update
   :ensure t
   :config
   (setq auto-package-update-delete-old-versions t
         auto-package-update-interval 4)
   (auto-package-update-maybe))

(when (equal ""
             (shell-command-to-string "git config user.name"))
  (shell-command "git config --global user.name \"Matei Cotocel\"")
  (shell-command "git config --global user.email \"mcotocel@outlook.com\""))

(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(setq inhibit-splash-screen t
      inhibit-startup-echo-area-message t
      inhibit-startup-message t)
(setq ring-bell-function 'ignore)

(add-to-list 'default-frame-alist '(font . "Iosevka Nerd Font"))

(set-fontset-font t 'symbol (font-spec :family "Twemoji") nil 'prepend)

(defun org/prettify-set ()
    (interactive)
    (setq prettify-symbols-alist
        '(("#+begin_src" . "")
          ("#+BEGIN_SRC" . "")
          ("#+end_src" . "")
          ("#+END_SRC" . "")
          ("#+begin_example" . "")
          ("#+BEGIN_EXAMPLE" . "")
          ("#+end_example" . "")
          ("#+END_EXAMPLE" . "")
          ("#+results:" . "")
          ("#+RESULTS:" . "")
          ("#+begin_quote" . "❝")
          ("#+BEGIN_QUOTE" . "❝")
          ("#+end_quote" . "❞")
          ("#+END_QUOTE" . "❞")
          ("[ ]" . "☐")
          ("[-]" . "◯")
          ("[X]" . "☑"))))
  (add-hook 'org-mode-hook 'org/prettify-set)

  (defun prog/prettify-set ()
    (interactive)
    (setq prettify-symbols-alist
        '(("lambda" . "λ")
          ("->" . "→")
          ("<-" . "←")
          ("<=" . "≤")
          (">=" . "≥")
          ("!=" . "≠")
          ("~=" . "≃")
          ("=~" . "≃"))))
  (add-hook 'prog-mode-hook 'prog/prettify-set)

(global-prettify-symbols-mode)

(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

(dolist (mode '(org-mode-hook
                term-mode-hook
                eshell-mode-hook
                neotree-mode-hook
                elfeed-show-mode
                circe-channel-mode
                circe-chat-mode
                woman-mode-hook))
(add-hook mode (lambda () (display-line-numbers-mode 0))))

(setq recentf-save-file "~/.config/emacs/etc/recentf" ;; File for recentf
      recentf-max-saved-items 50)
(setq savehist-file "~/.config/emacs/etc/savehist" ;; File for save history
      history-length 150)
(setq save-place-file "~/.config/emacs/etc/saveplace") ;; File for save place
(setq bookmark-default-file "~/.config/emacs/etc/bookmarks") ;; File for bookmarks
(setq backup-directory-alist '(("." . "~/.config/emacs/backups")) ;; Directory for backups
      delete-old-versions t
      kept-old-versions 20
      vc-make-backup-files t
      version-control t)
(setq custom-file "~/.config/emacs/etc/custom.el") ;; For saved customizations
(setq create-lockfiles nil) ;; Disable lockfiles

(save-place-mode) ;; Save location
(global-visual-line-mode) ;; Wrap lines
(add-hook 'org-mode-hook 'flyspell-mode) ;; Spell checker

(setq require-final-newline t)

(defalias 'yes-or-no-p 'y-or-n-p)

(setq redisplay-dont-pause t
  scroll-margin 1
  scroll-step 1
  scroll-conservatively 10000
  scroll-preserve-screen-position 1
  scroll-up-aggressively 0.01
  scroll-down-aggressively 0.01)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

(setq disabled-command-function nil)

(add-to-list 'auto-mode-alist '("PKGBUILD\\'" . shell-script-mode))

(use-package exec-path-from-shell
   :config
   (exec-path-from-shell-initialize))

(use-package evil
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

(use-package evil-leader
  :config
  (global-evil-leader-mode)
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
    ;; General
    "<SPC>" 'counsel-M-x
    ".f" 'counsel-grep-or-swiper
    ".q" 'delete-frame
    ;; Undo
    "uv" 'undo-tree-visualize
    "uu" 'undo-tree-undo
    "ur" 'undo-tree-redo
    "uc" 'counsel-yank-pop
    ;; Files
    "fr" 'counsel-recentf
    "fb" 'counsel-bookmark
    "ff" 'counsel-find-file
    "fd" 'counsel-dired
    ;; Bufffers
    "bv" 'split-window-right
    "bh" 'split-window-below
    "bd" 'kill-current-buffer
    ;; Projectile
    "pf" 'projectile-find-file
    "pp" 'projectile-switch-project
    "pg" 'projectile-grep
    "pm" 'projectile-commander
    "pc" 'projectile-compile-project
    ;; Org mode
    "oc" 'org-edit-special
    "ol" 'org-latex-previw
    "ot" 'org-ctrl-c-ctrl-c
    "oi" 'org-toggle-inline-images
    "oa" 'org-agenda
    "os" 'org-schedule
    ; Export
    "oep" 'org-latex-export-to-pdf
    "oeh" 'org-html-export-to-html
    ; Roam
    "orf" 'org-roam-node-find
    "ori" 'org-roam-node-insert
    "oru" 'org-roam-db-sync
    ; Babel
    "obs" 'org-babel-execute-src-block
    "obb" 'org-babel-execute-buffer
    "obl" 'org-babel-load-file
    ;; Workgroups
    "wa" 'ivy-push-view
    "wd" 'ivy-pop-view
    "ws" 'ivy-switch-view
    ;; Help
    "hh" 'help
    "hk" 'describe-key
    "hv" 'describe-variable
    "hf" 'describe-function
    "hs" 'describe-symbol
    "hm" 'describe-mode
    ;; Magit
    "gs" 'magit-status))

(define-key evil-normal-state-map (kbd "M-s") 'save-buffer)
(define-key evil-normal-state-map (kbd "M-q") 'delete-window)
(define-key evil-normal-state-map (kbd "M-w") 'kill-current-buffer)

(define-key evil-normal-state-map (kbd "M-x") 'counsel-M-x)
(define-key evil-normal-state-map (kbd "<C-tab>") 'ivy-switch-buffer)

(define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
(define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
(define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
(define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)
(define-key evil-normal-state-map (kbd "M-j") 'evil-scroll-down)
(define-key evil-normal-state-map (kbd "M-k") 'evil-scroll-up)

(define-key evil-normal-state-map "u" 'undo-tree-undo)
(define-key evil-normal-state-map (kbd "C-r") 'undo-tree-redo)

(define-key evil-normal-state-map (kbd "M-t") 'neotree-toggle)
(define-key evil-normal-state-map (kbd "<C-return>") 'shr-browse-url)
(define-key key-translation-map (kbd "ESC") (kbd "C-g"))

(define-key evil-normal-state-map (kbd "C-=") 'text-scale-increase)
(define-key evil-normal-state-map (kbd "C--") 'text-scale-decrease)
(define-key evil-normal-state-map (kbd "C-0") 'text-scale-adjust)

(define-key evil-normal-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)

(defun my/c-c ()
  (interactive)
  (setq unread-command-events (listify-key-sequence (kbd "C-c"))))

(defun my/c-k ()
  (interactive)
  (setq unread-command-events (listify-key-sequence (kbd "C-k"))))

(evil-define-key 'normal global-map (kbd ",c") 'my/c-c)
(evil-define-key 'normal global-map (kbd ",k") 'my/c-k)

(set-default 'evil-normal-state-cursor 'hbar)
(set-default 'evil-insert-state-cursor 'bar)
(set-default 'evil-visual-state-cursor 'hbar)
(set-default 'evil-motion-state-cursor 'box)
(set-default 'evil-replace-state-cursor 'box)
(set-default 'evil-operator-state-cursor 'hbar)
(set-cursor-color "#80D1FF")
(setq-default cursor-type 'bar)

(setq evil-cross-lines t
      evil-move-beyond-eol t
      evil-want-fine-undo t
      evil-symbol-word-search t
      evil-want-Y-yank-to-eol t
      evil-cross-lines t)

(use-package which-key
  :config (which-key-mode)
  (which-key-setup-side-window-bottom)
  (setq which-key-idle-delay 0.1))

(use-package ivy
  :config (ivy-mode t)
  (setq ivy-initial-inputs-alist nil)
  (setq ivy-count-format "[%d/%d] ")
  (setq ivy-use-virtual-buffers t)
  (setq ivy-height 33)
(setq ivy-ignore-buffers '("\\` " "\\`\\*" "magit*")))

(use-package counsel
  :after ivy
  :config (counsel-mode t))

;; (use-package ivy-posframe
;;   :after ivy
;;   :config
;;   (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-top-center)))
;;   (setq ivy-posframe-parameters
;;     '((left-fringe . 30)
;;       (right-fringe . 30)))
;;   (ivy-posframe-mode t))

(use-package all-the-icons-ivy-rich
  :init (all-the-icons-ivy-rich-mode 1))

(use-package ivy-rich
  :init (ivy-rich-mode 1))

(use-package dashboard
  :config
  (setq dashboard-center-content t
    dashboard-show-shortcuts nil
    dashboard-banner-logo-title "Welcome to Emacs"
    dashboard-startup-banner "/home/matei/.config/emacs/pfp_rounded_small.png"
    dashboard-set-heading-icons t
    dashboard-set-file-icons t
    dashboard-set-navigator t)
  (setq dashboard-items '())
  (dashboard-setup-startup-hook))
(setq dashboard-navigator-buttons
      `(((,
         (all-the-icons-octicon "file-text" :height 1.0 :v-adjust 0.05)
         "Open recent files"
         "Open recent files"
         (lambda (&rest _) (counsel-recentf)))

        (,(all-the-icons-octicon "bookmark" :height 1.0 :v-adjust 0.0)
         "Open bookmarks"
         "Open bookmarks"
         (lambda (&rest _) (counsel-bookmark)))

        (,(all-the-icons-octicon "rocket" :height 1.0 :v-adjust 0.05)
         "Open projects"
         "Open projects"
         (lambda (&rest _) (projectile-switch-project))))

        ((,(all-the-icons-octicon "calendar" :height 1.0 :v-adjust 0.05)
         "View org agenda"
         "View org agenda"
         (lambda (&rest _) (org-agenda)))

        (,(all-the-icons-octicon "keyboard" :height 1.0 :v-adjust 0.0)
         "Restore session"
         "Restore session"
         (lambda (&rest _) (persp-state-load "~/.config/emacs/perspective/default.el"))))))
(setq dashboard-footer-messages '(
"While any text editor can save your files, only Emacs can save your soul"
"Welcome to the Church of Emacs"
"Emacs - The thermonuclear word processor"
"Escape Meta Alt Control Shift"
"Eight Megs And Constantly Swapping"
"Vi Vi Vi, the editor of the beast"))

(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))

(use-package neotree)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(add-hook 'neotree-mode-hook
         (lambda ()
           (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-quick-look)
           (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)
           (define-key evil-normal-state-local-map (kbd "g") 'neotree-refresh)
           (define-key evil-normal-state-local-map (kbd "n") 'neotree-next-line)
           (define-key evil-normal-state-local-map (kbd "p") 'neotree-previous-line)
           (define-key evil-normal-state-local-map (kbd "A") 'neotree-stretch-toggle)
           (define-key evil-normal-state-local-map (kbd "H") 'neotree-hidden-file-toggle)))

(use-package magit
  :defer t)

(use-package smartparens
  :config (smartparens-global-mode)
  (show-smartparens-mode))

(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package all-the-icons)

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :config (setq doom-modeline-height 25)
  (setq doom-modeline-icon t))

(use-package undo-tree
  :config
  (global-undo-tree-mode))
  (setq undo-tree-auto-save-history t)
  (setq undo-tree-history-directory-alist '(("." . "~/.config/emacs/undo")))

(use-package format-all
  :hook (prog-mode . format-all-mode))

(use-package doom-themes
  :config
  (load-theme 'doom-quiet-dark t)
  (doom-themes-neotree-config))

(setq mu4e-maildir (expand-file-name "~/Mail/"))

(setq mu4e-drafts-folder "/Drafts")
(setq mu4e-sent-folder   "/Sent")
(setq mu4e-trash-folder  "/Deleted")

(setq mu4e-get-mail-command "mbsync -a"
  mu4e-view-prefer-html t
  mu4e-update-interval 180
  mu4e-headers-auto-update t
  mu4e-compose-signature-auto-include nil
  mu4e-compose-format-flowed t)

(setq
 user-mail-address "mcotocel@outlook.com"
 user-full-name  "Matei Cotocel")

(setq mu4e-view-show-images t)

(setq message-send-mail-function 'smtpmail-send-it)
(setq smtpmail-smtp-server "smtp-mail.outlook.com")
(setq smtpmail-smtp-service 587 )
(setq smtpmail-auth-credentials (expand-file-name "~/.authinfo"))

(use-package circe)
(setq circe-network-options
      `(("Libera Chat"
         :nick "Specter"
         :channels (:after-auth "#unixporn" "#emacs")
         :nickserv-password ,libera-password)))
(setq enable-circe-display-images t)
(setq enable-circe-color-nicks t)
(add-hook 'circe-chat-mode-hook 'my-circe-prompt)
(defun my-circe-prompt ()
  (lui-set-prompt
   (concat (propertize (concat (buffer-name) ">")
                       'face 'circe-prompt-face)
           " ")))

(straight-use-package 'matrix-client)
(setq matrix-client-show-images t)

;;(use-package elcord
;;  :config
;;  (elcord-mode))

(use-package elfeed)
(setq elfeed-feeds
       '(("http://www.reddit.com/r/emacs.rss" tech emacs)
         ("http://www.reddit.com/r/terminal_porn.rss" tech)))
(add-to-list 'evil-emacs-state-modes 'elfeed-search-mode)
(add-to-list 'evil-emacs-state-modes 'elfeed-show-mode)

(use-package elfeed-dashboard
  :config
  (setq elfeed-dashboard-file "~/Org/elfeed-dashboard.org")
  (advice-add 'elfeed-search-quit-window :after #'elfeed-dashboard-update-links))
(evil-set-initial-state 'elfeed-dashboard-mode 'emacs)
;(setq browse-url-browser-function 'browse-url-generic
;    browse-url-generic-program "qutebrowser")

(use-package emms)
(emms-all)
(emms-default-players)
(setq emms-source-file-default-directory "/Volumes/PiNAS/Media/Music/")

(use-package lsp-mode
  :init
  :hook ((python-mode . lsp)
         (lua-mode . lsp)
         (sh-mode . lsp)
         (lisp-mode . lsp)
         (emacs-lisp-mode . lsp)
         (css-mode . lsp)
         (html-mode . lsp)
         (json-mode . lsp)
         (markdown-mode . lsp)
         (latex-mode . lsp)
         (go-mode . lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp
  :config
  (setq lsp-enable-symbol-highlighting nil)
  lsp-ui-doc-enable t
  lsp-lens-enable nil
  lsp-headerline-breadcrumb-enable nil
  lsp-ui-sideline-enable nil
  lsp-ui-sideline-enable t
  lsp-modeline-code-actions-enable t
  lsp-ui-sideline-enable t
  lsp-ui-doc-border nil
  lsp-eldoc-enable-hover t)
(setq lsp-log-io nil)
(setq lsp-enable-file-watchers nil)

(use-package lsp-ui :commands lsp-ui-mode)

(setq lsp-enable-symbol-highlighting nil)
(custom-set-faces '(nobreak-space ((t nil))))

(use-package company
  :hook (prog-mode . company-mode)
  :bind (:map company-active-map
              ("<tab>" . company-select-next)))

(setq company-idle-delay 0.1
      company-minimum-prefix-length 1
      company-selection-wrap-around t
      company-require-match 'never
      company-dabbrev-downcase nil
      company-dabbrev-ignore-case t
      company-dabbrev-other-buffers nil
      company-tooltip-limit 5
      company-tooltip-minimum-width 50)

(use-package company-box
  :hook (company-mode . company-box-mode)
  :config
  (setq company-box-scrollbar nil))

(use-package go-mode)
(use-package json-mode)
(use-package lua-mode)
(use-package nix-mode)
(use-package lsp-jedi
  :hook (python-mode . lsp-jedi))

(use-package yasnippet
  :hook (prog-mode . yas-global-mode))

(use-package yasnippet-snippets
  :defer t)

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package projectile
  :config (projectile-mode 1))

(use-package highlight-indent-guides
  :config (setq highlight-indent-guides-method 'character)
  :hook (prog-mode-hook . highlight-indent-guides-mode))

(setq org-directory "~/Org/"
      org-default-notes-file "~/Org/notes.org")
(setq org-agenda-files '("~/Org/"))

(setq org-export-backends '(latex md html))

(require 'org)
(require 'ox-latex)
(add-to-list 'org-latex-packages-alist '("" "minted"))
(setq org-latex-listings 'minted) 

(use-package htmlize)

(setq org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

(setq org-src-fontify-natively t)

(setq org-export-with-section-numbers nil)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (latex . t)))
(setq org-html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"./style.css\"/>"
  org-html-doctype "html5")

(use-package org-bullets
  :after org
  :hook
  (org-mode . (lambda () (org-bullets-mode 1))))

(setq org-hide-emphasis-markers t)
(setq org-image-actual-width '(300))
(set-face-attribute 'org-headline-done nil :strike-through t)
(setq org-agenda-start-on-weekday 0)
(setq org-src-tab-acts-natively t)

(setq org-todo-keywords
     '((sequence "TODO" "WAITING" "PAUSED" "ALMOST" "OPTIONAL" "IMPORTANT" "DONE")))
(setq org-todo-keyword-faces
  '(("TODO"      . (:foreground "#FF8080" :weight bold))
    ("WAITING"   . (:foreground "#FFFE80" :weight bold))
    ("PAUSED"    . (:foreground "#D5D5D5" :weight bold))
    ("ALMOST"    . (:foreground "#80D1FF" :weight bold))
    ("OPTIONAL"  . (:foreground "#C780FF" :weight bold))
    ("IMPORTANT" . (:foreground "#80FFE4" :weight bold))
    ("DONE"      . (:foreground "#97D59B" :weight bold))))

(use-package org-roam
  :custom
  (org-roam-directory "~/org/")
  :config
  (org-roam-setup)
  (require 'org-roam-protocol))

(setq org-roam-v2-ack t)

(use-package org-roam-ui
  :straight
  (:host github :repo "org-roam/org-roam-ui" :branch "main" :files ("*.el" "out"))
  :after org-roam
  :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

(setq org-capture-templates
    '(("t" "Todo" entry (file "~/Org/Refile.org")
       "* TODO %?\n%U" :empty-lines 1)
      ("n" "Note" entry (file "~/Org/Refile.org")
       "* NOTE %?\n%U" :empty-lines 1)))

(use-package ob-go
  :config (org-babel-do-load-languages
 'org-babel-load-languages
 '((go . t))))

(let* ((base-font-color     (face-foreground 'default nil 'default))
       (headline           `(:inherit default :weight bold :foreground "grey" :height 1.6)))

  (custom-theme-set-faces
   'user
   `(org-level-8 ((t (,@headline))))
   `(org-level-7 ((t (,@headline))))
   `(org-level-6 ((t (,@headline))))
   `(org-level-5 ((t (,@headline))))
   `(org-level-4 ((t (,@headline :height 1.2))))
   `(org-level-3 ((t (,@headline :height 1.3))))
   `(org-level-2 ((t (,@headline :height 1.4))))
   `(org-level-1 ((t (,@headline :height 1.5))))
   `(org-document-title ((t (,@headline :height 1.6 :underline nil))))))

(custom-theme-set-faces
 'user
 '(fixed-pitch ((t ( :family "Iosevka Nerd Font" :height 160)))))

(custom-theme-set-faces
 'user
 '(org-block                 ((t :inherit fixed-pitch)))
 '(org-code                  ((t :inherit fixed-pitch :weight normal)))
 '(org-document-info         ((t ,@headline :height 1.6)))
 '(org-document-info-keyword ((t :inherit (shadow fixed-pitch))))
 '(org-indent                ((t :inherit (org-hide fixed-pitch))))
 '(org-link                  ((t :foreground "royal blue" :underline t)))
 '(org-meta-line             ((t :inherit (font-lock-comment-face fixed-pitch))))
 '(org-property-value        ((t :inherit fixed-pitch)) t)
 '(org-special-keyword       ((t :inherit (font-lock-comment-face fixed-pitch))))
 '(org-table                 ((t :inherit fixed-pitch :foreground "#384149")))
 '(org-tag                   ((t :inherit (shadow fixed-pitch) :weight bold :height 0.8)))
 '(org-verbatim              ((t :inherit (shadow fixed-pitch)))))

(use-package org-present)

(defun edit-file-root ()
  "Use tramp to edit the current buffer as root"
  (interactive)
  (when buffer-file-name
    (find-alternate-file
     (concat "/sudo:root@localhost:"
             buffer-file-name))))
