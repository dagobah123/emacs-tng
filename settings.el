;;; settings.el --- settings file  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Settings file

;;; Code:

(abbrev-mode t) ;;; Enable abbrev mode.
(display-time) ;;; Display time in mode-line.
(fringe-mode '(14 . 14)) ;;; Set fringe width.
(fset 'yes-or-no-p 'y-or-n-p) ;;; Use y and n instead of yes and no.
(global-company-mode) ;;; Enable company mode.
(global-hl-line-mode t) ;;; Enable global hl line.
(menu-bar-mode 0) ;;; Disable menu bar.
(olivetti-set-width 150) ;;; Set olivetti width.
(scroll-bar-mode 0) ;;; Disable scroll bar.
(setenv "LC_TIME" "en_US.UTF-8") ;;; Set environment to English.
(setq ag-arguments '("--java")) ;;; Set additional ag arguments.
(setq blink-cursor-blinks 0) ;;; Make cursor blink forever.
(setq confirm-kill-emacs 'y-or-n-p) ;;; Ask if Emacs should be closed.
(setq inhibit-startup-screen t) ;;; Disable startup screen.
(setq initial-scratch-message "") ;;; Make scratch message empty.
(setq ivy-read-action-function 'ivy-hydra-read-action) ;;; Ivy hydra.
(setq make-backup-files nil) ;;; Do not create backup files.
(setq package-check-signature nil) ;;; Disable package signature check.
(setq projectile-globally-ignored-directories '(".target" "target")) ;;; Globally ignored directories.
(setq projectile-globally-ignored-files '("*.~undo-tree~")) ;;; Globally ignored files.
(setq ring-bell-function 'ignore) ;;; Turn bell off.
(setq treemacs-icon-fallback-text (propertize "> " 'face 'font-lock-keyword-face)) ;;; Treemacs no icons.
(setq treemacs-no-png-images t) ;;; Treemacs no icons.
(setq-default indent-tabs-mode nil) ;;; Use spaces.
(setq-default tab-width 4) ;;; Set tab width to 4 spaces.
(setq-default truncate-lines t) ;;; Long lines will not wrap.
(show-paren-mode t) ;;; Show matching parentheses.
(tool-bar-mode 0) ;;; Disable tool bar.
(winner-mode t) ;;; Enable winner mode.

;;; settings.el ends here
