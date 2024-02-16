{ config, pkgs, ... }: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs29;
    extraPackages = epkgs:
      with epkgs; [
        all-the-icons
        all-the-icons-dired
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
        git-gutter-fringe
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
        multi-vterm
        neotree
        nix-mode
        ob-mermaid
        olivetti
        omnisharp
        orderless
        org-download
        org-modern
        org-ql
        org-roam
        org-roam-ui
        org-super-agenda
        perspective
        projectile
        rainbow-delimiters
        realgud
        smartparens
        tree-sitter
        tree-sitter-langs
        undo-tree
        vertico
        vterm
        which-key
        yasnippet
        yasnippet-snippets
      ];
    extraConfig = ''
            	    ;;;; init.el ---- My Emacs config
            	    ;;;; Commentary:
            	    ;;;; It's pretty messy, not the greatest, but it works for me
            	    ;;;; Code:

                  ;;; Org Mode

      ;; Publishing
      (require 'ox-latex)
      (require 'ox-publish)

                                              ; What I would like to export to
      (setq org-export-backends '(latex md html))

                                              ; What should be exported from a file
      (setq org-publish-use-timestamps-flag nil
            org-export-with-timestamps nil
            org-export-with-toc nil
            org-export-time-stamp-file nil
            org-export-with-broken-links t
            org-export-with-section-numbers nil
            org-html-validation-link nil
            org-src-fontify-natively t)

      (setq org-html-head "
                    <link rel=\"stylesheet\" type=\"text/css\" href=\"./style.css\"/>
                    <script defer src=\"https://eu.umami.is/script.js\" data-website-id=\"c7bd5e90-595f-42f1-b167-30cc61b5ecae\"></script>
                    "
            org-html-doctype "html5")

                                              ; PDF export options
      (add-to-list 'org-latex-packages-alist '("" "minted"))
      (setq org-latex-src-block-backend 'minted)

      (setq org-latex-pdf-process
            '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
              "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
              "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

      (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.3))

                                              ; What to publish
      (setq org-publish-project-alist
            '(
              ("vault:files"
               :base-directory "~/State/Vault/"
               :base-extension "org"
               :publishing-directory "~/State/Hosted Vault/"
               :recursive t
               :publishing-function org-html-publish-to-html
               :headline-levels 4
               :auto-preamble t
               )
              ("vault:assets"
               :base-directory "~/State/Vault/"
               :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
               :publishing-directory "~/State/Hosted Vault/"
               :recursive t
               :publishing-function org-publish-attachment
               )
              ("vault:images"
               :base-directory "~/State/Vault/img"
               :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
               :publishing-directory "~/State/Hosted Vault/img"
               :recursive t
               :publishing-function org-publish-attachment
               )))

      ;; UI
      (setq org-hide-emphasis-markers t
            org-image-actual-width '(300)
            org-agenda-start-on-weekday 0
            org-src-tab-acts-natively t
            org-agenda-tags-column 0
            org-agenda-block-separator ?─
            org-agenda-time-grid
            '((daily today remove-match)
              (0530 0600 0630 0700 0730 0800 0830 0900 0930 1000 1030 1100 1130 1200 1230 1300 1330 1400 1430 1500 1530 1600 1630 1700 1730 1800 1830 1900 1930 2000 2030 2100 2130 2200 2230)
              " ─ " "────────────────────────────────────────────────")
            org-agenda-current-time-string
            "◀── now ───────────────────────────────────────"
            org-startup-with-inline-images t)
      (set-face-attribute 'org-headline-done nil :strike-through t)
      (add-hook 'org-mode-hook #'global-org-modern-mode)

                                              ; Centering text
      (setq olivetti-body-width 0.7)
      (add-hook 'org-mode-hook 'olivetti-mode)

      ;; Org Roam
      (setq org-roam-directory (file-truename "~/State/Vault/"))
      (setq org-agenda-files '(
                               "~/State/Vault/20230831103307-agenda.org"
                               "~/State/Vault/20230901140829-birthdays.org"
                               "~/State/Vault/20231111112234-timetable.org"))
      (org-roam-db-autosync-mode)
      (cl-defmethod org-roam-node-directories ((node org-roam-node))
        (if-let ((dirs (file-name-directory (file-relative-name (org-roam-node-file node) org-roam-directory))))
            (format "(%s)" (car (split-string dirs "/")))
          ""))

      (setq org-id-extra-files (org-roam-list-files))

      (cl-defmethod org-roam-node-backlinkscount ((node org-roam-node))
        (let* ((count (caar (org-roam-db-query
                             [:select (funcall count source)
                                      :from links
                                      :where (= dest $s1)
                                      :and (= type "id")]
                             (org-roam-node-id node)))))
          (format "[%d]" count)))

      (setq org-roam-node-display-template "''${tags:30} ''${title:100} ''${backlinkscount:6}")

                                              ; Org Roam UI
      (setq org-roam-ui-sync-theme t
            org-roam-ui-follow t
            org-roam-ui-update-on-save t
            org-roam-ui-open-on-start t)

      ;; Agenda and capture
      (setq org-todo-keywords
            '((sequence "TODO" "RECURRING" "WORKING" "DONE")))
      (setq org-todo-keyword-faces
            '(("TODO" . (:foreground "#ff8080" :weight bold))
              ("RECURRING" . (:foreground "#fffe80" :weight bold))
              ("WORKING" . (:foreground "#ace1ff" :weight bold))
              ("DONE" . (:foreground "#97d59b" :weight bold))))

      (setq org-agenda-prefix-format
            '((agenda . "%t %s")))

      (setq org-agenda-hidden-separator "‌‌ ")
      (setq org-priority-highest ?A)
      (setq org-priority-lowest ?E)
      (setq org-priority-faces '((?A . (:foreground "#ff8080" :weight bold))
                                 (?B . (:foreground "#fffe80" :weight bold))
                                 (?C . (:foreground "#97d59b" :weight bold))
                                 (?D . (:foreground "#ace1ff" :weight bold))
                                 (?E . (:foreground "#c780ff" :weight bold))))

      (setq org-capture-templates '(("j" "Journal Entry" entry (file+datetree "~/State/Vault/20231129171720-journal.org") "* %?" :empty-lines 1)))

                                              ; Open agenda in a single frame
      (setq org-agenda-window-setup 'only-window)
      (setq org-agenda-window-frame-fractions '(0.7 . 0.7))

                                              ; Super agenda to add some niceties
      (org-super-agenda-mode)
      (setq org-super-agenda-groups
            '((:name "Critical"
                     :time-grid t
                     :priority "A")
              (:name "Important"
                     :time-grid t
                     :priority "B")
              (:name "Standard"
                     :time-grid t
                     :priority "C")
              (:name "Low"
                     :time-grid t
                     :priority "D")
              (:name "Trivial"
                     :time-grid t
                     :priority "E")
              (:name "School"
                     :time-grid t
                     :tag ("cs" "epq" "maths" "physics" "sc"))
              (:name "RPGs"
                     :time-grid t
                     :tag "rpg")))

                                              ; Category icons
;      (setq org-agenda-category-icon-alist
;            `(("maths" ,(list (nerd-icons-mdicon "nf-md-square_root")) nil nil :ascent center)
;              ("physics" ,(list (nerd-icons-mdicon "nf-md-atom")) nil nil :ascent center)
;              ("cs" ,(list (nerd-icons-mdicon "nf-md-code_tags")) nil nil :ascent center)
;              ("sc" ,(list (nerd-icons-mdicon "nf-md-brain")) nil nil :ascent center)
;              ("rpg" ,(list (nerd-icons-mdicon "nf-md-dice_d20")) nil nil :ascent center)))
;
      ;; Misc

                                              ; Easily add an image
      (require 'org-download)
      (setq-default org-download-image-dir "~/State/Vault/img/")

                                              ; Literate programming
      (org-babel-do-load-languages
       'org-babel-load-languages
       '((mermaid . t)
         (latex . t)
         (python . t)
         (gnuplot . t)))

                  ;;; Misc

      ;; Defaults
      (setq-default
       delete-by-moving-to-trash t
       require-final-newline t
       custom-safe-themes t
       disabled-command-function nil
       vc-follow-symlinks)
      (setq kill-buffer-query-functions (delq 'process-kill-buffer-query-function kill-buffer-query-functions))

      (defalias 'yes-or-no-p 'y-or-n-p)

      ;; Scroll settings
      (setq scroll-margin 1
            scroll-step 1
            scroll-conservatively 10000)

      ;; Git settings
      (when (equal ""
            	     (shell-command-to-string "git config user.name"))
        (shell-command "git config --global user.name \"Matei Cotocel\"")
        (shell-command "git config --global user.email \"mcotocel@outlook.com\""))

      ;; Line numbers
      (global-display-line-numbers-mode)
      (setq display-line-numbers-type 'relative)
      (dolist (mode '(org-mode-hook
            	        term-mode-hook
                      vterm-mode-hook
            	        dashboard-mode-hook
            	        eshell-mode-hook
            	        neotree-mode-hook
            	        elfeed-show-mode-hook
            	        doc-view-mode-hook
            	        xwidget-webkit-mode-hook
            	        woman-mode-hook))
        (add-hook mode (lambda () (display-line-numbers-mode 0))))

      ;; File locations
      (setq recentf-save-file "~/.config/emacs/etc/recentf"
            recentf-max-saved-items 50)
      (setq savehist-file "~/.config/emacs/etc/savehist"
            history-length 150)
      (setq save-place-file "~/.config/emacs/etc/saveplace")
      (setq bookmark-default-file "~/.config/emacs/etc/bookmarks")
      (setq backup-directory-alist '(("." . "~/.config/emacs/backups"))
            delete-old-versions t
            kept-old-versions 20
            vc-make-backup-files t
            version-control t)
      (setq custom-file "~/.config/emacs/etc/custom.el")
      (setq create-lockfiles nil)
      (save-place-mode)
      (add-function :after after-focus-change-function (lambda () (save-some-buffers t)))
      (global-visual-line-mode)
      (global-auto-revert-mode)
      (recentf-mode)
      (add-hook 'org-mode-hook 'flyspell-mode)

      ;; Indentation
      (setq-default indent-tabs-mode nil
            	      tab-width 4)
      (setq indent-line-function 'insert-tab) ;; Convert tabs to spaces

      ;; Cursors
      (set-default 'evil-normal-state-cursor 'hbar)
      (set-default 'evil-insert-state-cursor 'bar)
      (set-default 'evil-visual-state-cursor 'hbar)
      (set-default 'evil-motion-state-cursor 'box)
      (set-default 'evil-replace-state-cursor 'box)
      (set-default 'evil-operator-state-cursor 'hbar)
      (set-cursor-color "#80D1FF")
      (setq-default cursor-type 'bar)

      ;; Undoing
      (global-undo-tree-mode)
      (setq undo-tree-auto-save-history t)
      (setq undo-tree-history-directory-alist '(("." . "~/.config/emacs/undo")))

      (format-all-mode)

      ;; Workspaces
      (persp-mode)

      (setq persp-state-default-file "~/.config/emacs/pesrp-save.el")
      (add-hook 'kill-emacs-hook #'persp-state-save)

                  ;;; Keybinds and Evil

      (evil-mode 1)
      (evil-collection-init)

      (setq evil-cross-lines t
            evil-move-beyond-eol t
            evil-symbol-word-search t
            evil-want-Y-yank-to-eol t
            evil-want-integration t
            evil-want-keybinding nil
            evil-cross-lines t)

      (evil-set-initial-state 'org-agenda-mode 'normal)

      (global-evil-leader-mode)
      (evil-leader/set-leader "<SPC>")
      (evil-leader/set-key
        ;; General
        ".f" 'consult-line
        ".q" 'delete-frame
        ".e" 'eval-region
        ".;" 'eval-expression
        "SPC" 'execute-extended-command
        ;; Undo
        "uv" 'undo-tree-visualize
        "uu" 'undo-tree-undo
        "ur" 'undo-tree-redo
        "uc" 'consult-yank-pop
        ;; Dictionaries
        "dd" 'dictionary-lookup-definition
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
        ;; Projectile
        "pa" 'projectile-add-known-project
        "pr" 'projectile-recentf
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
        "oc" 'org-capture
        "oe" 'excalidraw-launch
        "oaa" 'org-agenda
        "oac" 'consult-org-agenda
        ;; LSP
        "lfd" 'lsp-ui-peek-find-definitions
        "lfr" 'lsp-ui-peek-find-references
        "lg" 'lsp-ui-doc-glance
        "le" 'lsp-ui-flycheck-list
        "lh" 'lsp-toggle-symbol-highlight
        "lr" 'lsp-rename
        ;; Workspaces
        "wf" 'persp-switch
        "ws" 'persp-state-save
        "wl" 'persp-state-load
        "wd" 'persp-kill
        "wr" 'persp-rename
        "w]" 'persp-next
        "w[" 'persp-prev
        ;; Help
        "hh" 'help
        "hk" 'describe-key
        "hv" 'describe-variable
        "hf" 'describe-function
        "hs" 'describe-symbol
        "hm" 'describe-mode
        ;; Emojis
        "es" 'emoji-search
        ;; Magit
        "gi" 'magit-init
        "gc" 'magit-commit
        "gp" 'magit-push
        "gC" 'magit-clone
        "gs" 'magit-status)

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

      ;; If you forget which key is bound to what
      (which-key-mode)
      (which-key-setup-side-window-bottom)
      (setq which-key-idle-delay 0.1)

                  ;;; Minibuffer

      ;; Nicer minibuffer
      (vertico-mode 1)
      (setq vertico-resize nil
            vertico-count 14
            vertico-cycle t)

      ;; Fuzzy find minibuffer
      (setq completion-styles '(orderless)
            completion-category-defaults nil
            completion-category-overrides '((file (styles partial-completion))))

      ;; Add more info to marginalia
      (marginalia-mode)

                  ;;; UI

      ;; Simplify the UI
      (menu-bar-mode -1)
      (scroll-bar-mode -1)
      (tool-bar-mode -1)
      (setq inhibit-splash-screen nil
            inhibit-startup-echo-area-message t
            server-client-instructions nil
            inhibit-startup-message t)
      (setq ring-bell-function 'ignore)

      ;; Git Gutter
      (add-hook 'prog-mode-hook 'git-gutter-mode)
      (setq git-gutter:update-interval 0.02)
      (setq git-gutter:added-sign "█")
      (setq git-gutter:deleted-sign "█")
      (setq git-gutter:modified-sign "█")

      ;; Dashboard
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
            dashboard-items 'nil
            dashboard-set-footer 'nil)

      (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
      (add-hook 'neo-after-create-hook (lambda (&optional dummy) (setq mode-line-format nil)))
      (add-hook 'dashboard-after-initialize-hook (lambda (&optional dummy) (setq mode-line-format nil)))

      ;; Modeline
      (doom-modeline-mode 1)
      (setq doom-modeline-height 30
            doom-modeline-bar-width 3
            doom-modeline-buffer-encoding 'nondefault
            doom-modeline-major-mode-icon t
            doom-modeline-minor-modes nil
            doom-modeline-lsp nil
            doom-modeline-icon t)

      (custom-set-faces
       '(mode-line ((t (:family "Iosevka Nerd Font" :height 120)))))

      ;; Minimap
      (setq minimap-window-location 'right
            minimap-update-delay 0
            minimap-width-fraction 0.1
            minimap-minimum-width 10
            minimap-major-modes '(text-mode prog-mode))
      (minimap-mode 0)

      ;; Themes
      (load-file "~/.config/emacs/doom-quiet-dark-theme.el")
      (enable-theme 'doom-quiet-dark)
      (doom-themes-neotree-config)

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
      (add-to-list 'org-emphasis-alist
                   '("*" (bold :foreground "#ff8080")
                     ))

      ;; Misc
      (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

                  ;;; Programming

      ;; Auto-close delimiters
      (smartparens-global-mode)

      ;; Delimiter coloring
      (setq highlight-indent-guides-method 'character)
      (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

      ;; Indentation guides
      (highlight-indent-guides-mode)
      (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)

      ;; Language server protocol
      (require 'lsp)
      (add-hook 'python-mode-hook #'lsp)
      (add-hook 'sh-mode-hook #'lsp)
      (add-hook 'css-mode-hook #'lsp)
      (add-hook 'html-mode-hook #'lsp)
      (add-hook 'json-mode-hook #'lsp)
      (add-hook 'latex-mode-hook #'lsp)
      (add-hook 'nix-mode-hook #'lsp)
      (add-hook 'csharp-mode-hook 'omnisharp-mode)

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

      ;; Parsing library
      (global-tree-sitter-mode)
      (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

      ;; Completion library
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

      ;; Snippets
      (add-hook 'prog-mode-hook 'yas-global-mode)

      ;; Project management
      (projectile-mode)

                  ;;; Functions
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
        "Publish all org files in a directory."
        (interactive)
        (save-excursion
          (mapc
           (lambda (file)
             (with-current-buffer
                 (find-file-noselect file)
               (org-html-export-to-html)))
           (file-expand-wildcards  "*.org"))))

      (defun excalidraw-launch ()
        "Launch excalidraw in a browser."
        (interactive)
        (browse-url "https://excalidraw.com"))

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
      background-color: #000000;
      font-family: monospace;
      font-size: 16px;
    }

    pre, blockquote, src {
      background: #000000;
      border: 3px solid #0f1719;
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

    b {
      color: #ff8080;
    }
  '';
  home.file.".config/emacs/doom-quiet-dark-theme.el".text = ''
    ;;; doom-quiet-dark-theme.el --- doom-one code with modified colours -*- lexical-binding: t; no-byte-compile: t; -*-
    ;;
    ;; Author: Matei Cotocel <https://github.com/mcotocel>
    ;;
    ;;; Code:

    (require 'doom-themes)

    ;;
    ;;; Variables

    (defgroup doom-quiet-dark-theme nil
      "Options for the `doom-quiet-dark' theme."
      :group 'doom-themes)

    (defcustom doom-quiet-dark-brighter-modeline nil
      "If non-nil, more vivid colors will be used to style the mode-line."
      :group 'doom-quiet-dark-theme
      :type 'boolean)

    (defcustom doom-quiet-dark-brighter-comments nil
      "If non-nil, comments will be highlighted in more vivid colors."
      :group 'doom-quiet-dark-theme
      :type 'boolean)

    (defcustom doom-quiet-dark-comment-bg doom-quiet-dark-brighter-comments
      "If non-nil, comments will have a subtle highlight to enhance their
    legibility."
      :group 'doom-quiet-dark-theme
      :type 'boolean)

    (defcustom doom-quiet-dark-padded-modeline doom-themes-padded-modeline
      "If non-nil, adds a 4px padding to the mode-line.
    Can be an integer to determine the exact padding."
      :group 'doom-quiet-dark-theme
      :type '(choice integer boolean))


    ;;
    ;;; Theme definition

    (def-doom-theme doom-quiet-dark
      "A dark theme inspired by Atom One Dark."

      ;; name        default   256           16
      ((bg         '("#000000" "black"       "black"  ))
       (fg         '("#d5d5d5" "#bfbfbf"     "brightwhite"  ))

       ;; These are off-color variants of bg/fg, used primarily for `solaire-mode',
       ;; but can also be useful as a basis for subtle highlights (e.g. for hl-line
       ;; or region), especially when paired with the `doom-darken', `doom-lighten',
       ;; and `doom-blend' helper functions.
       (bg-alt     '("#0c1213" "black"       "black"        ))
       (fg-alt     '("#d5d5d5" "#2d2d2d"     "white"        ))

       ;; These should represent a spectrum from bg to fg, where base0 is a starker
       ;; bg and base8 is a starker fg. For example, if bg is light grey and fg is
       ;; dark grey, base0 should be white and base8 should be black.
       (base0      '("#080808" "black"       "black"        ))
       (base1      '("#101010" "#1e1e1e"     "brightblack"  ))
       (base2      '("#181818" "#2e2e2e"     "brightblack"  ))
       (base3      '("#000000" "#262626"     "brightblack"  ))
       (base4      '("#282828" "#3f3f3f"     "brightblack"  ))
       (base5      '("#303030" "#525252"     "brightblack"  ))
       (base6      '("#303030" "#6b6b6b"     "brightblack"  ))
       (base7      '("#383838" "#979797"     "brightblack"  ))
       (base8      '("#404040" "#dfdfdf"     "white"        ))

       (grey       base4)
       (red        '("#ff8080" "#ff6655" "red"          ))
       (orange     '("#ffb27f" "#dd8844" "brightred"    ))
       (green      '("#97d59b" "#99bb66" "green"        ))
       (teal       '("#7fffe7" "#44b9b1" "brightgreen"  ))
       (yellow     '("#fffe80" "#ECBE7B" "yellow"       ))
       (blue       '("#80d1ff" "#51afef" "brightblue"   ))
       (dark-blue  '("#6a7dfc" "#2257A0" "blue"         ))
       (magenta    '("#c780ff" "#c678dd" "brightmagenta"))
       (violet     '("#c780ff" "#a9a1e1" "magenta"      ))
       (cyan       '("#ace1ff" "#46D9FF" "brightcyan"   ))
       (dark-cyan  '("#49bafc" "#5699AF" "cyan"         ))

       ;; These are the "universal syntax classes" that doom-themes establishes.
       ;; These *must* be included in every doom themes, or your theme will throw an
       ;; error, as they are used in the base theme defined in doom-themes-base.
       (highlight      blue)
       (vertical-bar   (doom-darken base1 0.1))
       (selection      dark-blue)
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
        :background (if doom-quiet-dark-comment-bg (doom-lighten bg 0.05) 'unspecified))
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
       (ivy-current-match :background dark-blue :distant-foreground base0 :weight 'normal)
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

    ;;; doom-quiet-dark-theme.el ends here
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
