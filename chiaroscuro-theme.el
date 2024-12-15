


































































;;; chiaroscuro-theme.el --- Theme consisting of multiple themes
;;; Commentary:
;;; Code:
(load-file "~/.emacs.d/theme/common/variables.el")
(load-file "~/.emacs.d/theme/common/default.el")

;; load light or dark diff colors
(if (>= INDEX-CHIAROSCURO INDEX-HIGH-CONTRAST)
    (progn (load-file "~/.emacs.d/theme/common/diff-middle.el"))
  (progn (load-file "~/.emacs.d/theme/common/diff-light.el")))

;; dark themes start here
(if (>= INDEX-CHIAROSCURO INDEX-LOW-CHROMA)
    (load-file "~/.emacs.d/theme/common/dark.el"))

(if (> INDEX-CHIAROSCURO INDEX-DEFAULT)
   (progn
     (if (eq INDEX-CHIAROSCURO INDEX-ECLIPSE)
         (load-file "~/.emacs.d/theme/light/eclipse.el"))
     (if (eq INDEX-CHIAROSCURO INDEX-CONSOLE-LIGHT)
         (load-file "~/.emacs.d/theme/light/console-light.el"))
     (if (eq INDEX-CHIAROSCURO INDEX-COLOR-CHANGE-LIGHT)
         (load-file "~/.emacs.d/theme/color-changer/color-changer.el"))
     (if (eq INDEX-CHIAROSCURO INDEX-HIGH-CONTRAST)
         (load-file "~/.emacs.d/theme/light/high-contrast.el"))
     (if (eq INDEX-CHIAROSCURO INDEX-GRAY)
         (load-file "~/.emacs.d/theme/light/gray.el"))
     (if (eq INDEX-CHIAROSCURO INDEX-LOW-CHROMA)
         (load-file "~/.emacs.d/theme/dark/low-chroma.el"))
     (if (eq INDEX-CHIAROSCURO INDEX-BLUE)
         (load-file "~/.emacs.d/theme/dark/blue.el"))
     (if (eq INDEX-CHIAROSCURO INDEX-NEON)
         (load-file "~/.emacs.d/theme/dark/neon.el"))
     (if (eq INDEX-CHIAROSCURO INDEX-CONSOLE-DARK)
         (load-file "~/.emacs.d/theme/dark/console-dark.el"))
     (if (eq INDEX-CHIAROSCURO INDEX-RED)
         (load-file "~/.emacs.d/theme/dark/red.el"))
     (if (eq INDEX-CHIAROSCURO INDEX-CASABLANCA)
         (load-file "~/.emacs.d/theme/dark/casablanca.el"))
     (if (eq INDEX-CHIAROSCURO INDEX-COLOR-CHANGE-DARK)
         (load-file "~/.emacs.d/theme/color-changer/color-changer.el"))

     ;; reset index
     (if (> INDEX-CHIAROSCURO number-of-themes) (setq INDEX-CHIAROSCURO 0))
     (if (< INDEX-CHIAROSCURO 0) (setq INDEX-CHIAROSCURO number-of-themes))

     (deftheme chiaroscuro)

     (custom-theme-set-faces 'chiaroscuro

(if (eq INDEX-CHIAROSCURO INDEX-HIGH-CONTRAST)
   (progn
     `(default ((t (:foreground ,text-normal :background ,background :bold t )))))
 (progn `(default ((t (:foreground ,text-normal :background ,background :bold nil ))))))

`(ac-candidate-face ((t (:foreground ,text-normal :background ,background-fringe ))))
`(ac-candidate-mouse-face ((t (:foreground ,text-normal :background ,background-fringe ))))
`(ac-completion-face ((t (:foreground ,text-highlight-1 :background ,background-fringe :bold t ))))
`(ac-selection-face ((t (:foreground ,text-highlight-1 :background ,background-fringe :bold t ))))
`(ansi-color-bold ((t (:foreground ,text-highlight-1 :background unspecified :bold t ))))
`(bm-fringe-face ((t (:foreground ,text-highlight-1 :background unspecified ))))
`(bm-fringe-persistent-face ((t (:foreground ,text-highlight-1 :background unspecified ))))
`(bookmark-face ((t (:foreground ,text-normal :background unspecified ))))
`(comint-highlight-prompt ((t (:foreground ,text-highlight-1 :background unspecified ))))
`(company-tooltip ((t (:foreground ,text-normal :background ,background-fringe ))))
`(company-tooltip-annotation ((t (:foreground ,text-lower :background ,background-fringe ))))
`(company-tooltip-annotation-selection ((t (:foreground ,text-low :background ,background-fringe :bold nil ))))
`(company-tooltip-common ((t (:foreground ,text-highlight-1 :background ,background-fringe :bold t ))))
`(company-tooltip-scrollbar-thumb ((t (:foreground ,text-normal :background ,background-mode-line :bold nil :italic nil ))))
`(company-tooltip-scrollbar-track ((t (:foreground ,text-normal :background ,background-mode-line :bold nil :italic nil ))))
`(company-tooltip-selection ((t (:foreground ,text-highlight-1 :background ,background-fringe :bold t ))))
`(compilation-info ((t (:foreground ,text-highlight-1 :bold t :underline t ))))
`(cua-rectangle ((t (:foreground ,text-highlight-1 :background ,background-region :bold t ))))
`(custom-button ((t (:foreground ,text-highlight-1 :background ,background-mode-line ))))
`(diff-file-header ((t (:foreground ,text-highlight-1 :background ,background-magit :bold t ))))
`(diff-header ((t (:foreground ,text-highlight-1 :background ,background-magit ))))
`(dired-directory ((t (:foreground ,text-highlight-3 :background unspecified :bold t ))))
`(dired-header ((t (:foreground ,text-highlight-3 :background unspecified :bold t ))))
`(dired-ignored ((t (:foreground ,text-normal :background unspecified ))))
`(dired-mark ((t (:foreground ,text-highlight-1 :background unspecified ))))
`(dired-marked ((t (:foreground ,text-highlight-1 :background unspecified ))))
`(dired-narrow-blink ((t (:foreground ,text-normal :background unspecified ))))
`(dired-perm-write ((t (:foreground ,text-normal :background unspecified ))))
`(dired-set-id ((t (:foreground ,text-normal :background unspecified ))))
`(dired-special ((t (:foreground ,text-highlight-1 ))))
`(dired-symlink ((t (:foreground ,text-normal :background unspecified ))))
`(dired-warning ((t (:foreground ,text-normal :background unspecified ))))
`(direded-flagged ((t (:foreground ,text-highlight-1 :background unspecified ))))
`(ediff-current-diff-A ((t (:foreground "#000000" :background ,background-diff-current-A ))))
`(ediff-current-diff-Ancestor ((t (:foreground "#000000" :background ,background-diff-current-Ancestor ))))
`(ediff-current-diff-B ((t (:foreground "#000000" :background ,background-diff-current-B ))))
`(ediff-current-diff-C ((t (:foreground "#000000" :background ,background-diff-current-C ))))
`(ediff-even-diff-A ((t (:foreground "#000000" :background ,background-diff-even-A ))))
`(ediff-even-diff-Ancestor ((t (:foreground "#000000" :background ,background-diff-even-Ancestor ))))
`(ediff-even-diff-B ((t (:foreground "#000000" :background ,background-diff-even-B ))))
`(ediff-even-diff-C ((t (:foreground "#000000" :background ,background-diff-even-C ))))
`(ediff-fine-diff-A ((t (:foreground "#000000" :background ,background-diff-fine-A ))))
`(ediff-fine-diff-Ancestor ((t (:foreground "#000000" :background ,background-diff-fine-Ancestor ))))
`(ediff-fine-diff-B ((t (:foreground "#000000" :background ,background-diff-fine-B ))))
`(ediff-fine-diff-C ((t (:foreground "#000000" :background ,background-diff-fine-C ))))
`(ediff-odd-diff-A ((t (:foreground "#000000" :background ,background-diff-odd-A ))))
`(ediff-odd-diff-Ancestor ((t (:foreground "#000000" :background ,background-diff-odd-Ancestor ))))
`(ediff-odd-diff-B ((t (:foreground "#000000" :background ,background-diff-odd-B ))))
`(ediff-odd-diff-C ((t (:foreground "#000000" :background ,background-diff-odd-C ))))
`(eglot-diagnostic-tag-unnecessary-face ((t (:foreground ,text-warning :background unspecified :bold t ))))
`(eglot-mode-line ((t (:foreground ,text-highlight-1 :background unspecified :bold t ))))
`(elfeed-log-date-face ((t (:foreground ,text-normal :background unspecified ))))
`(elfeed-log-debug-level-face ((t (:foreground ,text-normal :background unspecified ))))
`(elfeed-log-error-level-face ((t (:foreground ,text-normal :background unspecified ))))
`(elfeed-log-info-level-face ((t (:foreground ,text-normal :background unspecified ))))
`(elfeed-log-warn-level-face ((t (:foreground ,text-normal :background unspecified ))))
`(elfeed-search-date-face ((t (:foreground ,text-normal :background unspecified ))))
`(elfeed-search-feed-face ((t (:foreground ,text-normal :background unspecified ))))
`(elfeed-search-filter-face ((t (:foreground ,text-normal :background unspecified ))))
`(elfeed-search-last-update-face ((t (:foreground ,text-normal :background unspecified ))))
`(elfeed-search-tag-face ((t (:foreground ,text-normal :background unspecified ))))
`(elfeed-search-title-face ((t (:foreground ,text-normal :background unspecified ))))
`(elfeed-search-unread-count-face ((t (:foreground ,text-normal :background unspecified ))))
`(elfeed-search-unread-title-face ((t (:foreground ,text-normal :background unspecified ))))
`(eshell-ls-directory ((t (:foreground ,text-highlight-1 :background unspecified :bold t ))))
`(eshell-prompt ((t (:foreground ,text-highlight-1 :background unspecified ))))
`(evil-ex-lazy-highlight ((t (:foreground ,text-highlight-1 :background unspecified ))))
`(evil-ex-search ((t (:foreground ,text-highlight-1 :background unspecified ))))
`(evil-ex-substitute-matches ((t (:foreground ,text-highlight-1 :background unspecified ))))
`(eww-form-checkbox ((t (:foreground ,text-highlight-1 :background ,background-mode-line ))))
`(eww-form-select ((t (:foreground ,text-highlight-1 :background ,background-mode-line ))))
`(eww-form-submit ((t (:foreground ,text-highlight-1 :background ,background-mode-line ))))
`(eww-form-text ((t (:foreground ,text-highlight-1 :background ,background-mode-line ))))
`(eww-form-textarea ((t (:foreground ,text-highlight-1 :background ,background-mode-line ))))
`(eww-valid-certificate ((t (:foreground ,text-highlight-1 :background ,background-mode-line :bold t ))))
`(flycheck-error ((t (:foreground ,text-error :bold t :underline t ))))
`(flycheck-error-list-checker-name ((t (:foreground ,text-normal :bold t ))))
`(flycheck-error-list-column-number ((t (:foreground ,text-normal :bold t ))))
`(flycheck-error-list-error ((t (:foreground ,text-error :bold t :underline t ))))
`(flycheck-error-list-error-message ((t (:foreground ,text-error :bold t ))))
`(flycheck-error-list-filename ((t (:foreground ,text-normal :bold t ))))
`(flycheck-error-list-highlight ((t (:foreground ,text-normal :bold t :underline t ))))
`(flycheck-error-list-id ((t (:foreground ,text-normal :bold t ))))
`(flycheck-error-list-id-with-explainer ((t (:foreground ,text-normal :bold t ))))
`(flycheck-error-list-info ((t (:foreground ,text-highlight-1 :bold t ))))
`(flycheck-error-list-line-number ((t (:foreground ,text-normal :bold t ))))
`(flycheck-error-list-warning ((t (:foreground ,text-warning :bold t ))))
`(flycheck-fringe-error ((t (:foreground ,text-error :bold t ))))
`(flycheck-fringe-info ((t (:foreground ,text-info :bold t ))))
`(flycheck-fringe-warning ((t (:foreground ,text-warning :bold t ))))
`(focus-unfocused ((t (:foreground ,text-lower ))))
`(font-lock-bracket-face ((t (:foreground ,text-highlight-1 ))))
`(font-lock-builtin-face ((t (:foreground ,text-type :bold t ))))
`(font-lock-comment-delimiter-face ((t (:foreground ,text-comment ))))
`(font-lock-comment-face ((t (:foreground ,text-comment ))))
`(font-lock-constant-face ((t (:foreground ,text-constant ))))
`(font-lock-doc-face ((t (:foreground ,text-comment ))))
`(font-lock-function-call-face ((t (:foreground ,text-highlight-1 ))))
`(font-lock-function-name-face ((t (:foreground ,text-function ))))
`(font-lock-keyword-face ((t (:foreground ,text-keyword :bold t ))))
`(font-lock-number-face ((t (:foreground ,text-highlight-1 ))))
`(font-lock-preprocessor-face ((t (:foreground ,text-preprocessor ))))
`(font-lock-regexp-face ((t (:foreground ,text-highlight-1 :bold t ))))
`(font-lock-regexp-grouping-backslash ((t (:foreground ,text-highlight-1 ))))
`(font-lock-regexp-grouping-construct ((t (:foreground ,text-highlight-3 ))))
`(font-lock-string-face ((t (:foreground ,text-low ))))
`(font-lock-type-face ((t (:foreground ,text-type :bold t ))))
`(font-lock-variable-name-face ((t (:foreground ,text-variable ))))
`(font-lock-variable-use-face ((t (:foreground ,text-variable ))))
`(fringe ((t (:foreground ,text-normal :background ,background-fringe ))))
`(header-line ((t (:foreground ,text-normal ))))
`(helm-M-x-key ((t (:foreground ,text-match-2 ))))
`(helm-bookmark-directory ((t (:foreground ,text-highlight-1 :background unspecified :bold t ))))
`(helm-bookmark-file ((t (:foreground ,text-normal ))))
`(helm-buffer-directory ((t (:foreground ,text-highlight-1 :bold t ))))
`(helm-buffer-file ((t (:foreground ,text-normal :background unspecified ))))
`(helm-buffer-saved-out ((t (:foreground ,text-normal ))))
`(helm-candidate-number ((t (:foreground ,text-highlight-1 ))))
`(helm-ff-directory ((t (:foreground ,text-highlight-1 :bold t ))))
`(helm-ff-dotted-directory ((t (:foreground ,text-low :background unspecified ))))
`(helm-ff-executable ((t (:foreground ,text-highlight-1 :background unspecified ))))
`(helm-ff-file-extension ((t (:foreground ,text-low :background unspecified :bold nil ))))
`(helm-ff-prefix ((t (:foreground ,text-highlight-1 :background unspecified ))))
`(helm-ff-rsync-progress ((t (:foreground ,text-normal ))))
`(helm-grep-file ((t (:foreground ,text-normal :background unspecified :bold t :underline t ))))
`(helm-grep-finish ((t (:foreground ,text-highlight-1 :background unspecified ))))
`(helm-grep-lineno ((t (:foreground ,text-low ))))
`(helm-grep-match ((t (:foreground ,text-highlight-1 :background unspecified :bold t ))))
`(helm-lsp-diag-error ((t (:foreground ,text-error :bold t :underline t ))))
`(helm-lsp-diag-info ((t (:foreground ,text-error :bold t :underline t ))))
`(helm-match ((t (:foreground ,text-match-1 :background ,background-match-1 :bold t ))))
`(helm-match-item ((t (:foreground ,text-match-1 :background ,background-match-1 :bold t ))))
`(helm-minibuffer-prompt ((t (:foreground ,text-normal :background unspecified ))))
`(helm-non-file-buffer ((t (:foreground ,text-lower :background unspecified :italic t ))))
`(helm-selection ((t (:foreground ,text-match-1 :background ,background-match-2 :bold t ))))
`(helm-selection-line ((t (:foreground ,text-match-2 :background ,background-match-2 :bold t ))))
`(helm-separator ((t (:foreground ,text-low :background ,background-hl ))))
`(helm-source-header ((t (:foreground ,text-highlight-1 :background unspecified :bold t :height 1.3 :family "Sans Serif" ))))
`(helm-swoop-target-line-block-face ((t (:foreground ,text-hl :background unspecified ))))
`(helm-swoop-target-line-face ((t (:foreground ,text-match-2 :background ,background-match-2 :bold t ))))
`(helm-swoop-target-word-face ((t (:foreground ,text-match-1 :background ,background-match-1 :bold t ))))
`(help-key-binding ((t (:foreground ,text-highlight-1 :background unspecified :bold t ))))
`(highlight ((t (:foreground ,text-highlight-1 :background unspecified ))))
`(hl-line ((t (:foreground ,text-hl :background ,background-hl ))))
`(hydra-face-blue ((t (:foreground ,text-highlight-1 :bold t ))))
`(hydra-face-red ((t (:foreground ,text-highlight-1 :bold t ))))
`(ido-first-match ((t (:foreground ,text-match-1 :background ,background-hl ))))
`(ido-only-match ((t (:foreground ,text-match-1 :background ,background-hl ))))
`(ido-subdir ((t (:foreground ,text-normal ))))
`(iedit-occurrence ((t (:foreground ,text-match-1 :background ,background-match-1 :bold t ))))
`(info-menu-star ((t (:foreground ,text-normal :background unspecified ))))
`(info-node ((t (:foreground ,text-highlight-1 :background unspecified :bold t :italic t ))))
`(info-xref ((t (:foreground ,text-link :background unspecified :underline t ))))
`(info-xref-visited ((t (:foreground ,text-low :background unspecified :underline t ))))
`(isearch ((t (:foreground ,text-highlight-1 :background unspecified ))))
`(ivy-current-match ((t (:foreground ,text-match-2 :background ,background-match-2 :bold t ))))
`(ivy-grep-info ((t (:foreground ,text-highlight-1 :background unspecified ))))
`(ivy-grep-line-number ((t (:foreground ,text-highlight-1 :background unspecified ))))
`(ivy-match-required-face ((t (:foreground ,text-highlight-1 :background unspecified ))))
`(ivy-minibuffer-match-face-1 ((t (:foreground ,text-match-1 :background ,background-match-1 :bold t ))))
`(ivy-minibuffer-match-face-2 ((t (:foreground ,text-match-1 :background ,background-match-1 :bold t ))))
`(ivy-minibuffer-match-face-3 ((t (:foreground ,text-match-1 :background ,background-match-1 :bold t ))))
`(ivy-minibuffer-match-face-4 ((t (:foreground ,text-match-1 :background ,background-match-1 :bold t ))))
`(ivy-modified-buffer ((t (:foreground ,text-low :background unspecified :bold t :italic t ))))
`(ivy-modified-outside-buffer ((t (:foreground ,text-low :background unspecified :bold t :italic t ))))
`(ivy-org ((t (:foreground ,text-low :background unspecified :italic t ))))
`(ivy-subdir ((t (:bold t ))))
`(ivy-virtual ((t (:foreground ,text-lower ))))
`(lazy-highlight ((t (:foreground ,text-highlight-1 :background unspecified ))))
`(lazy-highlight ((t (:foreground ,text-highlight-1 :background unspecified ))))
`(line-number ((t (:foreground ,text-line-number :background ,background-fringe ))))
`(line-number-current-line ((t (:foreground ,text-line-number :background ,background-fringe :bold t ))))
`(line-number-major-tick ((t (:foreground ,text-line-number :background ,background-fringe ))))
`(line-number-minor-tick ((t (:foreground ,text-line-number :background ,background-fringe ))))
`(link ((t (:foreground ,text-normal :underline t ))))
`(lsp-face-highlight-read ((t (:foreground ,text-highlight-1 :background unspecified ))))
`(lsp-face-highlight-write ((t (:foreground ,text-highlight-1 :background unspecified ))))
`(lsp-flycheck-warning-unnecessary-face ((t (:foreground ,text-warning :bold t :underline t ))))
`(magit-blame-heading ((t (:foreground ,text-normal :background ,background-fringe ))))
`(magit-blame-highlight ((t (:foreground ,text-normal :background ,background-fringe ))))
`(magit-blame-margin ((t (:foreground ,text-normal :background ,background-fringe ))))
`(magit-branch-current ((t (:foreground ,text-highlight-1 :background unspecified :bold t :box (:line-width 1 :color ,text-highlight-1) ))))
`(magit-branch-local ((t (:foreground ,text-highlight-1 :background unspecified :bold t :box (:line-width 1 :color ,text-highlight-1) ))))
`(magit-branch-remote ((t (:foreground ,text-highlight-3 :background unspecified :bold t :box (:line-width 1 :color ,text-highlight-3) ))))
`(magit-branch-remote-head ((t (:foreground ,text-highlight-3 :background unspecified :bold t :box (:line-width 1 :color ,text-highlight-3) :bold t :italic t ))))
`(magit-branch-upstream ((t (:foreground ,text-highlight-3 :background unspecified :bold t :box (:line-width 1 :color ,text-highlight-3) ))))
`(magit-diff-conflict-heading ((t (:foreground ,text-normal :background ,background-magit ))))
`(magit-diff-context ((t (:foreground ,text-lower :background unspecified ))))
`(magit-diff-context-highlight ((t (:foreground ,text-normal :background ,background-magit-dark ))))
`(magit-diff-file-heading ((t (:foreground ,text-lower :background unspecified :bold t ))))
`(magit-diff-file-heading-highlight ((t (:foreground ,text-highlight-1 :background ,background-magit :bold t ))))
`(magit-diff-file-heading-selection ((t (:foreground ,text-highlight-1 :background unspecified :bold t ))))
`(magit-diff-hunk-heading ((t (:foreground ,text-low :background ,background-magit ))))
`(magit-diff-hunk-heading-highlight ((t (:foreground ,text-highlight-1 :background ,background-magit ))))
`(magit-diff-hunk-heading-selection ((t (:foreground ,text-highlight-1 :background ,background-magit ))))
`(magit-hash ((t (:foreground ,text-low ))))
`(magit-header-line ((t (:foreground ,text-highlight-1 :bold t ))))
`(magit-header-line-key ((t (:foreground ,text-highlight-1 :bold t ))))
`(magit-keyword-squash ((t (:foreground ,text-normal ))))
`(magit-log-author ((t (:foreground ,text-low ))))
`(magit-log-date ((t (:foreground ,text-low ))))
`(magit-reflog-amend ((t (:foreground ,text-normal ))))
`(magit-reflog-checkout ((t (:foreground ,text-normal ))))
`(magit-reflog-cherry-pick ((t (:foreground ,text-normal ))))
`(magit-reflog-commit ((t (:foreground ,text-normal ))))
`(magit-reflog-merge ((t (:foreground ,text-normal ))))
`(magit-reflog-other ((t (:foreground ,text-normal ))))
`(magit-reflog-rebase ((t (:foreground ,text-normal ))))
`(magit-reflog-remote ((t (:foreground ,text-normal ))))
`(magit-reflog-reset ((t (:foreground ,text-normal ))))
`(magit-section-heading ((t (:foreground ,text-low :bold t ))))
`(magit-section-highlight ((t (:foreground ,text-hl :background ,background-hl :bold t ))))
`(magit-sequence-head ((t (:foreground ,text-highlight-1 :bold t ))))
`(match ((t (:foreground ,text-highlight-1 :background unspecified :bold t ))))
`(message-header-cc ((t (:foreground ,text-normal ))))
`(message-header-name ((t (:foreground ,text-normal ))))
`(message-header-newsgroups ((t (:foreground ,text-normal ))))
`(message-header-other ((t (:foreground ,text-normal ))))
`(message-header-subject ((t (:foreground ,text-normal ))))
`(message-header-to ((t (:foreground ,text-normal ))))
`(minibuffer-prompt ((t (:foreground ,text-normal :background unspecified ))))
`(mode-line ((t (:foreground ,text-highlight-1 :background ,background-mode-line :box (:line-width 8 :color ,background-mode-line) ))))
`(mode-line-buffer-id ((t (:foreground ,text-highlight-3 :bold t ))))
`(mode-line-highlight ((t (:foreground ,text-highlight-3 :background ,background-mode-line))))
`(mode-line-inactive ((t (:foreground ,text-low :background ,background-mode-line :box (:line-width 8 :color ,background-mode-line) ))))
`(org-agenda-column-dateline ((t (:foreground ,text-normal :underline t ))))
`(org-agenda-date ((t (:foreground ,text-low :bold t ))))
`(org-agenda-date-today ((t (:foreground ,text-normal :bold t :italic t ))))
`(org-agenda-date-weekend ((t (:foreground ,text-lower :bold t ))))
`(org-agenda-diary ((t (:foreground ,text-normal ))))
`(org-agenda-dimmed-todo-face ((t (:foreground ,text-low ))))
`(org-agenda-done ((t (:foreground ,text-lower :background unspecified ))))
`(org-agenda-filter-category ((t (:foreground ,text-highlight-1 ))))
`(org-agenda-filter-effort ((t (:foreground ,text-highlight-1 ))))
`(org-agenda-filter-regexp ((t (:foreground ,text-highlight-1 ))))
`(org-agenda-filter-tags ((t (:foreground ,text-highlight-1 ))))
`(org-agenda-restriction-lock ((t (:foreground ,text-highlight-1 ))))
`(org-agenda-structure ((t (:foreground ,text-low ))))
`(org-archived ((t (:foreground ,text-normal :background unspecified ))))
`(org-block ((t (:foreground ,text-normal :background unspecified :italic t ))))
`(org-block-begin-line ((t (:foreground ,text-lower :background unspecified ))))
`(org-block-end-line ((t (:foreground ,text-lower :background unspecified ))))
`(org-checkbox-statistics-done ((t (:foreground ,text-low :background unspecified ))))
`(org-column ((t (:foreground ,text-normal :background unspecified ))))
`(org-column-title ((t (:foreground ,text-normal :background unspecified ))))
`(org-date-selected ((t (:foreground ,text-highlight-1 :background ,background-hl ))))
`(org-document-info ((t (:foreground ,text-normal :background unspecified ))))
`(org-document-info-keyword ((t (:foreground ,text-normal :background unspecified ))))
`(org-document-title ((t (:foreground ,text-normal :background unspecified ))))
`(org-done ((t (:foreground ,text-lower :bold t ))))
`(org-drawer ((t (:foreground ,text-normal :background unspecified ))))
`(org-ellipsis ((t (:foreground ,text-normal :background unspecified ))))
`(org-footnote ((t (:foreground ,text-normal :background unspecified ))))
`(org-formula ((t (:foreground ,text-normal :background unspecified ))))
`(org-headline-done ((t (:foreground ,text-low :background unspecified ))))
`(org-headline-todo ((t (:foreground ,text-normal :background unspecified ))))
`(org-hide ((t (:foreground ,text-normal :background unspecified ))))
`(org-imminent-deadline ((t (:foreground ,text-normal :background unspecified :bold t ))))
`(org-latex-and-related ((t (:foreground ,text-normal :background unspecified ))))
`(org-link ((t (:foreground ,text-link :background unspecified :bold t :underline t ))))
`(org-list-dt ((t (:foreground ,text-normal :background unspecified ))))
`(org-macro ((t (:foreground ,text-normal :background unspecified ))))
`(org-meta-line ((t (:foreground ,text-normal :background unspecified ))))
`(org-property-value ((t (:foreground ,text-normal :background unspecified ))))
`(org-quote ((t (:foreground ,text-normal :background unspecified :italic t ))))
`(org-scheduled ((t (:foreground ,text-normal :background unspecified ))))
`(org-sexp-date ((t (:foreground ,text-normal :background unspecified ))))
`(org-tag-group ((t (:foreground ,text-normal :background unspecified ))))
`(org-target ((t (:foreground ,text-normal :background unspecified :underline t ))))
`(org-time-grid ((t (:foreground ,text-normal :background unspecified ))))
`(org-upcoming-deadline ((t (:foreground ,text-low :background unspecified ))))
`(org-upcoming-distant-deadline ((t (:foreground ,text-lower :background unspecified ))))
`(popup-face ((t (:foreground ,text-normal :background ,background-fringe :bold nil :italic nil ))))
`(popup-isearch-match ((t (:foreground ,text-normal :background ,background-fringe :bold nil :italic nil ))))
`(popup-menu-face ((t (:foreground ,text-normal :background ,background-fringe :bold nil :italic nil ))))
`(popup-menu-mouse-face ((t (:foreground ,text-normal :background ,background-fringe :bold nil :italic nil ))))
`(popup-menu-selection-face ((t (:foreground ,text-normal :background ,background-fringe :bold nil :italic nil ))))
`(popup-menu-summary-face ((t (:foreground ,text-normal :background ,background-fringe :bold nil :italic nil ))))
`(popup-scroll-bar-background-face ((t (:foreground ,text-normal :background ,background-mode-line :bold nil :italic nil ))))
`(popup-scroll-bar-foreground-face ((t (:foreground ,text-normal :background ,background-mode-line :bold nil :italic nil ))))
`(popup-summary-face ((t (:foreground ,text-normal :background ,background-fringe :bold nil :italic nil ))))
`(popup-tip-face ((t (:foreground ,text-normal :background ,background-fringe :bold nil :italic nil ))))
`(region ((t (:foreground "#000000" :background ,background-region ))))
`(secondary-selection ((t (:foreground ,text-highlight-1 :background unspecified ))))
`(show-paren-match ((t (:foreground ,text-highlight-1 :background unspecified :bold t ))))
`(shr-link ((t (:foreground ,text-link :background ,background :underline t ))))
`(speed-type-correct ((t (:foreground ,text-lower ))))
`(speed-type-default ((t (:foreground ,text-normal ))))
`(speed-type-mistake ((t (:foreground ,background-diff-current-A ))))
`(swiper-background-match-1-face-1 ((t (:foreground ,text-match-1 :background ,background-match-1 :bold t ))))
`(swiper-background-match-1-face-2 ((t (:foreground ,text-match-1 :background ,background-match-1 :bold t ))))
`(swiper-background-match-1-face-3 ((t (:foreground ,text-match-1 :background ,background-match-1 :bold t ))))
`(swiper-background-match-1-face-4 ((t (:foreground ,text-match-1 :background ,background-match-1 :bold t ))))
`(swiper-line-face ((t (:foreground ,text-match-2 :background ,background-match-2 :bold t ))))
`(swiper-match-face-1 ((t (:foreground ,text-match-1 :background ,background-match-1 :bold t ))))
`(swiper-match-face-2 ((t (:foreground ,text-match-1 :background ,background-match-1 :bold t ))))
`(swiper-match-face-3 ((t (:foreground ,text-match-1 :background ,background-match-1 :bold t ))))
`(swiper-match-face-4 ((t (:foreground ,text-match-1 :background ,background-match-1 :bold t ))))
`(tab-bar ((t (:foreground ,text-normal :background ,background-mode-line ))))
`(tab-bar-tab ((t (:foreground ,text-highlight-3 :background ,background-mode-line :bold t :box (:line-width 8 :color ,background-mode-line) ))))
`(tab-bar-tab-group-current ((t (:foreground ,text-highlight-1 :background unspecified ))))
`(tab-bar-tab-group-inactive ((t (:foreground ,text-highlight-1 :background unspecified ))))
`(tab-bar-tab-inactive ((t (:foreground ,text-highlight-1 :background ,background-mode-line :box (:line-width 8 :color ,background-mode-line) ))))
`(tab-bar-tab-ungrouped ((t (:foreground ,text-highlight-1 :background unspecified ))))
`(tab-line ((t (:foreground ,text-highlight-1 :background unspecified ))))
`(transient-key-exit ((t (:foreground ,text-highlight-1 :bold t ))))
`(transient-key-return ((t (:foreground ,text-highlight-1 :bold t ))))
`(transient-key-stay ((t (:foreground ,text-highlight-1 :bold t ))))
`(transient-red ((t (:foreground ,text-highlight-1 :background unspecified ))))
`(treemacs-directory-collapsed-face ((t (:foreground ,text-low :background unspecified ))))
`(treemacs-directory-face ((t (:foreground ,text-highlight-1 :background unspecified :bold t ))))
`(treemacs-file-face ((t (:foreground ,text-normal :background unspecified ))))
`(treemacs-fringe-indicator-face ((t (:foreground ,background-mode-line :background unspecified :bold t ))))
`(treemacs-git-added-face ((t (:foreground ,text-highlight-1 :background unspecified :bold t ))))
`(treemacs-git-ignored-face ((t (:foreground ,text-low :background unspecified :bold t ))))
`(treemacs-git-modified-face ((t (:foreground ,text-highlight-1 :background unspecified :bold t ))))
`(treemacs-git-renamed-face ((t (:foreground ,text-highlight-1 :background unspecified :bold t ))))
`(treemacs-git-untracked-face ((t (:foreground ,text-low :background unspecified :bold t ))))
`(treemacs-root-face ((t (:foreground ,text-highlight-1 :background unspecified :bold t ))))
`(vertical-border ((t (:foreground ,background ))))
`(whitespace-line ((t (:background unspecified ))))
`(whitespace-newline ((t (:foreground ,text-whitespace :background unspecified ))))
`(whitespace-space ((t (:foreground ,text-whitespace :background unspecified ))))
`(xref-match ((t (:foreground ,text-highlight-1 :background unspecified :bold t ))))
`(ztreep-diff-model-add-face ((t (:foreground ,text-highlight-1 :background unspecified ))))
`(ztreep-diff-model-normal-face ((t (:foreground ,text-normal :background unspecified ))))
)))

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'chiaroscuro)

;;; chiaroscuro-theme.el ends here