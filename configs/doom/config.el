;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq nerd-icons-font-names '("SymbolsNerdFontMono-Regular.ttf"))

(setq shell-file-name (executable-find "bash")
      user-full-name "John Doe"
      user-mail-address "john@doe.com"
      doom-font (font-spec :family "Roboto Mono" :size 14 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "Roboto" :size 14)
      doom-serif-font (font-spec :family "Libre Baskerville" :size 14)
      doom-theme 'doom-one
      display-line-numbers-type 'relative
      org-ellipsis " ▼ "
      org-directory "~/org")

;; linenumbers are everywhere, and they are all mine
(global-display-line-numbers-mode)

;; any-coding font
(add-hook 'prog-mode-hook (lambda () (buffer-face-set '(:family "Iosevka" :height 125))))

;; fish workaround as suggested by doom
(setq-default vterm-shell (executable-find "fish"))
(setq-default explicit-shell-file-name (executable-find "fish"))

;; better pdf support
(pdf-tools-install)

;; remap window splits to split+follow
(defun vsplit-window-and-follow ()
  "Split window vertically"
  (interactive)
  (+evil/window-vsplit-and-follow)
  (mode-line-other-buffer))

(defun hsplit-window-and-follow ()
  "Split window horizontally"
  (interactive)
  (+evil/window-split-and-follow)
  (mode-line-other-buffer))

(map! :leader
      :prefix "w"
      :desc "VSplit and follow" "v" #'vsplit-window-and-follow)
(map! :leader
      :prefix "w"
      :desc "HSplit and follow" "s" #'hsplit-window-and-follow)

(use-package! tree-sitter
  :hook
  (prog-mode . global-tree-sitter-mode))

;;
;; org-mode
;;
(require 'org)
(after! org
  (setq org-attach-dir-relative t))

(with-eval-after-load 'flycheck
  (flycheck-add-mode 'proselint 'org-mode))

(require 'find-lisp)
(setq org-capture-templates
      `(("i" "Inbox" entry  (file "gtd/inbox.org")
         ,(concat "* TODO %?\n"
                  "/Entered on/ %U"))
        ("e" "Eye Pills" entry (file+olp+datetree "logs/eyes.org")
         "* %<%R> %?")
        ("t" "Time Tracking" entry (file+olp+datetree "logs/daily.org")
         "* %<%R> %?")
        ("s" "Slipbox" entry (file "braindump/inbox.org")
         "* %?\n")
        ))

(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "PROG(p)" "INTR(i)" "DONE(d)")))

(setq org-log-done 'time
      org-log-into-drawer t
      org-log-state-notes-insert-after-drawers nil)

(setq org-fast-tag-selection-single-key nil)
(setq org-refile-use-outline-path 'file
      org-outline-path-complete-in-steps nil)
(setq org-refile-allow-creating-parent-nodes 'confirm
      org-refile-targets '(("projects.org" . (:level . 1))))

;; org-agenda
(setq
 jethro/org-agenda-directory (expand-file-name "gtd/" org-directory)
 org-agenda-files (append (find-lisp-find-files jethro/org-agenda-directory "\.org$")
                          (find-lisp-find-files (expand-file-name "logs/" org-directory) "\.org$")
                          '("projects.org" "areas.org"))
 org-agenda-sticky t
 ;; minimalist view
 org-agenda-hide-tags-regexp "."
 org-agenda-prefix-format '((agenda . " %i %-12:c%?-12t% s")
                            (todo   . " ")
                            (tags   . " %i %-12:c")
                            (search . " %i %-12:c"))
 ;; Show the daily agenda by default.
 org-agenda-span 'day
 org-agenda-start-day nil
 ;; Hide tasks that are scheduled in the future.
 org-agenda-todo-ignore-scheduled 'future
 ;; Use "second" instead of "day" for time comparison.
 ;; It hides tasks with a scheduled time like "<2020-11-15 Sun 11:30>"
 org-agenda-todo-ignore-time-comparison-use-seconds t
 ;; Hide the deadline prewarning prior to scheduled date.
 org-agenda-skip-deadline-prewarning-if-scheduled 'pre-scheduled
 org-agenda-custom-commands '(("n" "Agenda / INTR / PROG / NEXT"
                               ((agenda "" ((org-agenda-overriding-header "Scheduled")
                                            (org-agenda-time-grid nil)
                                            (org-agenda-prefix-format " %i %-12:c ")))
                                (todo "INTR" ((org-agenda-overriding-header "INTR")))
                                (todo "PROG" ((org-agenda-overriding-header "PROG")))
                                (todo "NEXT" ((org-agenda-overriding-header "NEXT"))))
                               nil)
                              ("p" "Priority views"
                               ((todo "TODO" ((org-agenda-skip-function '(org-agenda-skip-entry-if 'notregexp "\\[#A\\]"))
                                              (org-agenda-todo-ignore-scheduled 'all)
                                              (org-agenda-overriding-header "Urgent + Important")))
                                (todo "TODO" ((org-agenda-skip-function '(org-agenda-skip-entry-if 'notregexp "\\[#B\\]"))
                                              (org-agenda-todo-ignore-scheduled 'all)
                                              (org-agenda-overriding-header "Important")))
                                (todo "TODO" ((org-agenda-skip-function '(org-agenda-skip-entry-if 'notregexp "\\[#C\\]"))
                                              (org-agenda-todo-ignore-scheduled 'all)
                                              (org-agenda-overriding-header "Urgent"))))
                               nil)))

;;
;; org-roam
;;
(use-package! org-roam
  :init
  (map! :leader
        :prefix "n"
        :desc "org-roam" "l" #'org-roam-buffer-toggle
        :desc "org-roam-node-insert" "i" #'org-roam-node-insert
        :desc "org-roam-node-find" "f" #'org-roam-node-find
        :desc "org-roam-ref-find" "r" #'org-roam-ref-find
        :desc "org-roam-show-graph" "g" #'org-roam-show-graph
        :desc "org-roam-capture" "c" #'org-roam-capture)
  (setq org-roam-directory (file-truename (expand-file-name "braindump/" org-directory))
        org-roam-database-connector 'sqlite-builtin
        org-roam-completion-everywhere t
        org-roam-db-autosync-mode t
        org-id-link-to-org-use-id 'create-if-interactive)

  :config
  (org-roam-db-autosync-mode +1)
  (set-popup-rules!
    `((,(regexp-quote org-roam-buffer) ; persistent org-roam buffer
       :side right :width .33 :height .5 :ttl nil :modeline nil :quit nil :slot 1)
      ("^\\*org-roam: " ; node dedicated org-roam buffer
       :side right :width .33 :height .5 :ttl nil :modeline nil :quit nil :slot 2)))
  (add-hook 'org-roam-mode-hook #'turn-on-visual-line-mode)

  (setq org-roam-capture-templates
        '(("m" "main" plain
           "%?"
           :if-new (file+head "main/${slug}.org"
                              "#+title: ${title}\n")
           :immediate-finish t
           :unnarrowed t)
          ("r" "reference" plain "%?"
           :if-new
           (file+head "reference/${slug}.org" "#+title: ${title}\n")
           :immediate-finish t
           :unnarrowed t)
          ("a" "article" plain "%?"
           :if-new
           (file+head "articles/${slug}.org" "#+title: ${title}\n#+filetags: :article:\n")
           :immediate-finish t
           :unnarrowed t)))

  (defun jethro/tag-new-node-as-draft ()
    (org-roam-tag-add '("draft")))

  (add-hook 'org-roam-capture-new-node-hook #'jethro/tag-new-node-as-draft)

  (cl-defmethod org-roam-node-type ((node org-roam-node))
    "Return the TYPE of NODE."
    (condition-case nil
        (file-name-nondirectory
         (directory-file-name
          (file-name-directory
           (file-relative-name (org-roam-node-file node) org-roam-directory))))
      (error "")))

  (setq org-roam-node-display-template
        (concat "${type:15} ${title:*} " (propertize "${tags:10}" 'face 'org-tag)))

  (require 'citar)
  )


;;
;; bibtex and citar
;;
(setq jethro/default-bibliography `(,(expand-file-name "braindump/biblio.bib" org-directory)))

(after! bibtex-completion
  (setq! bibtex-completion-notes-path org-roam-directory
         bibtex-completion-bibliography jethro/default-bibliography
         org-cite-global-bibliography jethro/default-bibliography
         bibtex-completion-pdf-field "file"))

(after! bibtex-completion
  (after! org-roam
    (setq! bibtex-completion-notes-path org-roam-directory)))

(after! citar
  (map! :map org-mode-map
        :desc "Insert citation" "C-c b" #'citar-insert-citation)
  (setq citar-bibliography jethro/default-bibliography
        citar-org-roam-note-title-template "${author} - ${title}\npdf: ${file}"
        citar-at-point-function 'embark-act
        citar-symbol-separator "  "
        citar-format-reference-function 'citar-citeproc-format-reference
        org-cite-csl-styles-dir "~/papers/styles"
        citar-citeproc-csl-styles-dir org-cite-csl-styles-dir
        citar-citeproc-csl-locales-dir "~/papers/locales"
        citar-citeproc-csl-style (file-name-concat org-cite-csl-styles-dir "apa.csl")
        ))
