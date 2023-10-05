{ config, pkgs, ... }: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs29;
    extraPackages = epkgs: with epkgs; [
      all-the-icons
      all-the-icons-dired
      calfw
      calfw-org
      consult
      consult-projectile
      corfu
      dashboard
      doom-modeline
      doom-themes
      elfeed
      emacs-everywhere
      evil
      evil-collection
      evil-leader
      format-all
      gnuplot
      highlight-indent-guides
      htmlize
      json-mode
      ligature
      lsp-mode
      lsp-pyright
      lsp-ui
      lua-mode
      magit
      marginalia
      minimap
      neotree
      nix-mode
      ob-mermaid
      orderless
      org-roam
      org-roam-ui
      org-super-agenda
      org-ql
      perspective
      projectile
      rainbow-delimiters
      realgud
      smartparens
      tree-sitter
      tree-sitter-langs
      undo-tree
      vertico
      which-key
      yasnippet
      yasnippet-snippets
    ];
    extraConfig = ''
	    ;;;; init.el ---- My Emacs config
	    ;;;; Commentary:
	    ;;;; It's pretty messy, not the greatest, but it works for me
	    ;;;; Code:
	    
	    (require 'ox-latex)
	    (require 'ox-publish)
	    
	    (setq org-export-backends '(latex md html))
      
	    (setq org-publish-use-timestamps-flag nil
	          org-export-with-timestamps nil
	          org-export-with-toc nil
	          org-export-time-stamp-file nil
	          org-export-with-broken-links t
	          org-export-with-section-numbers nil
	          org-html-validation-link nil
	          org-src-fontify-natively t)

      (org-babel-do-load-languages
          'org-babel-load-languages
          '((mermaid . t)
            (latex . t)
            (python . t)
            (gnuplot . t)))
	    
	    (add-to-list 'org-latex-packages-alist '("" "minted"))
	    (setq org-latex-src-block-backend 'minted)

	    (setq org-latex-pdf-process
	          '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
	            "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
	            "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

      (setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))
	    
	    (setq org-html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"./style.css\"/>"
	      org-html-doctype "html5")

	    (setq org-hide-emphasis-markers t
	        org-image-actual-width '(300)
	        org-agenda-start-on-weekday 0
	        org-src-tab-acts-natively t
	        org-startup-with-inline-images t)
	    (set-face-attribute 'org-headline-done nil :strike-through t)

  	  (setq org-roam-directory (file-truename "~/Desktop/Folder/Vault/"))
  	  (org-roam-db-autosync-mode)
      (setq org-agenda-files '("~/Desktop/Folder/Vault/20230831103307-agenda.org"))
      ;;(setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:30}" 'face 'org-tag)))
      (require 'calfw)
      (require 'calfw-org)
      (setq cfw:display-calendar-holidays nil)
      (setq calendar-week-start-day 1)
      (cfw:org-create-source "#97D59B")
      (setq cfw:fchar-junction ?╋
            cfw:fchar-vertical-line ?┃
            cfw:fchar-horizontal-line ?━
            cfw:fchar-left-junction ?┣
            cfw:fchar-right-junction ?┫
            cfw:fchar-top-junction ?┯
            cfw:fchar-top-left-corner ?┏
            cfw:fchar-top-right-corner ?┓)

      (setq org-todo-keywords
            '((sequence "TODO" "RECURRING" "DONE")))
      (setq org-todo-keyword-faces
            '(("TODO" . (:foreground "#ff8080" :weight bold))
              ("RECURRING" . (:foreground "#fffe80" :weight bold))
              ("DONE" . (:foreground "#97d5nb" :weight bold))))

      (setq org-priority-highest ?A)
      (setq org-priority-lowest ?E)
      (setq org-priority-faces '((?A . (:foreground "#ff8080" :weight bold))
                                 (?B . (:foreground "#fffe80" :weight bold))
                                 (?C . (:foreground "#97d59b" :weight bold))
                                 (?D . (:foreground "#ace1ff" :weight bold))
                                 (?E . (:foreground "#c780ff" :weight bold))))

      (org-super-agenda-mode)
      (setq org-super-agenda-groups
             '((:name "Critical"
                      :priority "A")
               (:name "Important"
                      :priority "B")
               (:name "Standard"
                      :priority "C")
               (:name "Low"
                      :priority "D")
               (:name "Trivial"
                      :priority "E")
               (:name "School"
                      :tag ("cs" "epq" "maths" "physics" "sc-misc"))
               (:name "RPGs"
                      :tag "rpg")))

      (require 'ox-publish)
      (setq org-publish-project-alist
            '(
               ("vault:files"
                :base-directory "~/Desktop/Folder/Vault/"
                :base-extension "org"
                :publishing-directory "~/public_html/"
                :recursive t
                :publishing-function org-html-publish-to-html
                :headline-levels 4
                :auto-preamble t
                )
               ("vault:assets"
                :base-directory "~/Desktop/Folder/Vault/"
                :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
                :publishing-directory "~/public_html/"
                :recursive t
                :publishing-function org-publish-attachment
                )
               ("vault:images"
                :base-directory "~/Desktop/Folder/Vault/img"
                :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
                :publishing-directory "~/public_html/img"
                :recursive t
                :publishing-function org-publish-attachment
                )))

      (setq org-id-extra-files (org-roam-list-files))

      	(setq org-roam-ui-sync-theme t
      	      org-roam-ui-follow t
      	      org-roam-ui-update-on-save t
      	      org-roam-ui-open-on-start t)

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

  	  (setq evil-want-integration t)
  	  (setq evil-want-keybinding nil)
  	  (evil-mode 1)
	    (evil-collection-init)

      (evil-set-initial-state 'org-agenda-mode 'normal)
      ;;(evil-define-key 'insert org-mode-map (kbd "TAB") 'org-table-align)
	    
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
  	    ;; Org
  	    "orf" 'org-roam-node-find
  	    "org" 'org-roam-ui-open
  	    "ori" 'org-roam-node-insert
  	    "ort" 'org-roam-tag-add
        "ob" 'org-babel-execute-src-block
        "oi" 'org-toggle-inline-images
        "ol" 'org-latex-preview
        "oaa" 'org-agenda
        "oac" 'consult-org-agenda
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
  	    "gs" 'magit-status)

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
	    
	    (which-key-mode)
	    (which-key-setup-side-window-bottom)
	    (setq which-key-idle-delay 0.1)
	    
	    (vertico-mode 1)
	    (setq vertico-resize nil
	          vertico-count 14
	          vertico-cycle t)
	    
	    (setq completion-styles '(orderless)
	          completion-category-defaults nil
	          completion-category-overrides '((file (styles partial-completion))))
	    
	    (marginalia-mode)

	    (dashboard-setup-startup-hook)
	    
	    (setq dashboard-center-content t
	      dashboard-show-shortcuts nil
	      dashboard-startup-banner "~/.config/emacs/banner.txt"
	      dashboard-set-heading-icons t
	      dashboard-set-file-icons t
	      dashboard-set-navigator t
	      dashboard-init-info (format "Startup took around %ss" (round (string-to-number (emacs-init-time))))
        dashboard-display-icons-p t
        dashboard-icon-types 'nerd-icons
	      dashboard-set-footer 'nil)
      (setq dashboard-items '((agenda . 5)))


	    (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
	    (add-hook 'neo-after-create-hook (lambda (&optional dummy) (setq mode-line-format nil)))
	    (add-hook 'dashboard-after-initialize-hook (lambda (&optional dummy) (setq mode-line-format nil)))

      (smartparens-global-mode)
      
      (highlight-indent-guides-mode)
      (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
      (setq highlight-indent-guides-method 'character)

      (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

      (doom-modeline-mode 1)
      (setq doom-modeline-height 35
        doom-modeline-bar-width 2
        doom-modeline-buffer-encoding 'nondefault
        doom-modeline-major-mode-icon t
        doom-modeline-icon t)

      (custom-set-faces
       '(mode-line ((t (:family "Iosevka Nerd Font" :height 120)))))

      (setq minimap-window-location 'right
            minimap-update-delay 0
            minimap-width-fraction 0.1
            minimap-minimum-width 10
            minimap-major-modes '(text-mode prog-mode))
      (minimap-mode 0)

      (global-undo-tree-mode)
      (setq undo-tree-auto-save-history t)
      (setq undo-tree-history-directory-alist '(("." . "~/.config/emacs/undo")))

      (format-all-mode)

      (load-theme 'doom-quiet-dark t)
      (doom-themes-neotree-config)

      (setq elfeed-feeds
             '(("https://morss.it/https://kotaku.com/rss" gaming)))

      (require 'lsp)
      (add-hook 'python-mode-hook #'lsp)
      (add-hook 'sh-mode-hook #'lsp)
      (add-hook 'css-mode-hook #'lsp)
      (add-hook 'html-mode-hook #'lsp)
      (add-hook 'json-mode-hook #'lsp)
      (add-hook 'latex-mode-hook #'lsp)
      (add-hook 'nix-mode-hook #'lsp)

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
          lsp-enable-file-watchers nil)

      (setq lsp-enable-symbol-highlighting nil)

      (global-tree-sitter-mode)
      (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

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

      (add-hook 'corfu-mode-hook
                (lambda () (local-set-key (kbd "TAB") #'corfu-next)))

      (add-hook 'corfu-mode-hook
                (lambda () (local-set-key (kbd "S-TAB") #'corfu-previous)))

      (add-hook 'corfu-mode-hook
                (lambda () (local-set-key (kbd "<escape>") #'corfu-reset)))

      (global-corfu-mode)

      (add-hook 'prog-mode-hook 'yas-global-mode)

      (projectile-mode)

      (persp-mode)

      (setq persp-state-default-file "~/.config/emacs/pesrp-save.el")
      (add-hook 'kill-emacs-hook #'persp-state-save)
      
      ;; Font settings
      (add-to-list 'default-frame-alist '(font . "Iosevka Nerd Font-12")) ;; I like Iosevka, it's a nice font
      (set-fontset-font t 'emoji (font-spec :family "Twitter Color Emoji") nil 'prepend) ;; Some decent looking emojis
        (ligature-set-ligatures 't '("www"))
        (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
        ;; Iosevka ligatures
        (ligature-set-ligatures 'prog-mode '("<---" "<--"  "<<-" "<-" "->" "-->" "--->" "<->" "<-->" "<--->" "<---->" "<!--"
                                             "<==" "<===" "<=" "=>" "=>>" "==>" "===>" ">=" "<=>" "<==>" "<===>" "<====>" "<!---"
                                             "<~~" "<~" "~>" "~~>" "::" ":::" "==" "!=" "===" "!=="
                                             ":=" ":-" ":+" "<*" "<*>" "*>" "<|" "<|>" "|>" "+:" "-:" "=:" "<******>" "++" "+++"))
        (global-ligature-mode t)
      
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

     (setq org-agenda-category-icon-alist
           `(("maths" ,(list (nerd-icons-mdicon "nf-md-square_root")) nil nil :ascent center)
           ("physics" ,(list (nerd-icons-mdicon "nf-md-atom")) nil nil :ascent center)
           ("cs" ,(list (nerd-icons-mdicon "nf-md-code_tags")) nil nil :ascent center)
           ("sc-misc" ,(list (nerd-icons-mdicon "nf-md-brain")) nil nil :ascent center)
           ("rpg" ,(list (nerd-icons-mdicon "nf-md-dice_d20")) nil nil :ascent center)))

      (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

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
      
      (defun publish-dir-org ()
        "Publish all org files in a directory"
        (interactive)
        (save-excursion
          (mapc
           (lambda (file)
             (with-current-buffer
             (find-file-noselect file)
           (org-html-export-to-html)))
             (file-expand-wildcards  "*.org"))))

      (defun my-yank-calendar-date ()
        "Yank selected date from calendar."
        (interactive)
        (let* ((date (calendar-cursor-to-date))
               (day (car date))
               (month (cadr date))
               (year (caddr date))
               (day-name (calendar-day-name date))
               (formatted-date (format "<%04d-%02d-%02d %s>" year month day day-name))
               (formatted-text (format "SCHEDULED: %s" formatted-date)))
          (kill-new formatted-text)
          (message "Text yanked: %s" formatted-text)))
      
      (define-key evil-normal-state-map (kbd "SPC c") 'calendar)
      (add-hook 'calendar-mode-hook
                (lambda ()
                  (define-key calendar-mode-map (kbd "<return>") 'my-yank-calendar-date)))

      
      (provide 'init)
      ;; Local Variables:
      ;; byte-compile-warnings: (not free-vars unresolved)
      ;; End:
    '';
  };
  home.file.".config/emacs/style.css".text = ''
      body {
        padding: 50px;
        color: #d5d5d5;
        background-color: #0c1213;
        font-family: monospace;
        font-size: 16px;
      }
      
      pre, blockquote, src {
        background: #0f1719;
        border: 3px solid #0f1719;
        border-left: 3px solid #384149;
        font-family: monospace;
        padding-top: 15px;
        padding-bottom: 15px;
        padding-right: 15px;
        padding-left: 30px;
      }
      
      blockquote {
        font-size: 14px;
      }
      
      a {
        color: #80d1ff;
        text-decoration: none;
      }
      
      a:hover {
        font-weight: bold;
        text-decoration: none;
      }
      
      table, th, td {
        border: 1px solid;
        padding: 10px;
      }

      img {
        max-width: 400px;
      }
  '';
  home.file.".config/emacs/doom-quiet-dark-theme.el".text = ''
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
      
        ((bg         '("#0c1213"))
         (fg         '("#D5D5D5"))
      
         ;; These are off-color variants of bg/fg, used primarily for `solaire-mode',
         ;; but can also be useful as a basis for subtle highlights (e.g. for hl-line
         ;; or region), especially when paired with the `doom-darken', `doom-lighten',
         ;; and `doom-blend' helper functions.
         (bg-alt     '("#1f252a"))
         (fg-alt     '("#D5D5D5"))
      
         ;; These should represent a spectrum from bg to fg, where base0 is a starker
         ;; bg and base8 is a starker fg. For example, if bg is light grey and fg is
         ;; dark grey, base0 should be white and base8 should be black.
         (base0      '("#0c1213"))
         (base1      '("#0c1213"))
         (base2      '("#0c1213"))
         (base3      '("#0c1213"))
         (base4      '("#384149"))
         (base5      '("#384149"))
         (base6      '("#181e23"))
         (base7      '("#1f252a"))
         (base8      '("#989899"))
      
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
         (selection      base0)
         (builtin        magenta)
         (comments       base8)
         (doc-comments   base8)
         (constants      violet)
         (functions      magenta)
         (keywords       blue)
         (methods        cyan)
         (operators      blue)
         (type           yellow)
         (strings        green)
         (variables      magenta)
         (numbers        orange)
         (region         base7)
         (error          red)
         (warning        yellow)
         (success        green)
         (vc-modified    yellow)
         (vc-added       green)
         (vc-deleted     red)
      
         ;; These are extra color variables used only in this theme; i.e. they aren't
         ;; mandatory for derived themes.
         (modeline-fg              fg)
         (modeline-fg-alt          base5)
         (modeline-bg              (doom-lighten base3 0.05))
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
  '';
  home.file.".config/emacs/banner.txt".text = ''
      ▓█████  ███▄ ▄███▓ ▄▄▄       ▄████▄    ██████ 
      ▓█   ▀ ▓██▒▀█▀ ██▒▒████▄    ▒██▀ ▀█  ▒██    ▒ 
      ▒███   ▓██    ▓██░▒██  ▀█▄  ▒▓█    ▄ ░ ▓██▄   
      ▒▓█  ▄ ▒██    ▒██ ░██▄▄▄▄██ ▒▓▓▄ ▄██▒  ▒   ██▒
      ░▒████▒▒██▒   ░██▒ ▓█   ▓██▒▒ ▓███▀ ░▒██████▒▒
      ░░ ▒░ ░░ ▒░   ░  ░ ▒▒   ▓▒█░░ ░▒ ▒  ░▒ ▒▓▒ ▒ ░
       ░ ░  ░░  ░      ░  ▒   ▒▒ ░  ░  ▒   ░ ░▒  ░ ░
         ░   ░      ░     ░   ▒   ░        ░  ░  ░  
         ░  ░       ░         ░  ░░ ░            ░  
                                  ░                 
  '';
}
