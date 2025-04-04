;;; settings.el --- settings file
;;; Commentary:
;;; Settings file

;;; Code:

(display-time) ;;; Display time in mode-line.
(fset 'yes-or-no-p 'y-or-n-p) ;;; Use y and n instead of yes and no.
(menu-bar-mode 0) ;;; Disable menu bar.
(scroll-bar-mode 0) ;;; Disable scroll bar.
(setq blink-cursor-blinks 0) ;;; Make cursor blink forever.
(setq confirm-kill-emacs 'y-or-n-p) ;;; Ask if Emacs should be closed.
(setq inhibit-startup-screen t) ;;; Disable startup screen.
(setq initial-scratch-message "") ;;; Make scratch message empty.
(setq ivy-read-action-function 'ivy-hydra-read-action) ;;; Ivy hydra.
(setq make-backup-files nil) ;;; Do not create backup files.
(setq package-check-signature nil) ;;; Disable package signature check.
(setq projectile-globally-ignored-directories '(".target" "target")) ;;; Globally ignored directories
(setq projectile-globally-ignored-files '("*.~undo-tree~")) ;;; Globally ignored files
(setq ring-bell-function 'ignore)
(setq-default tab-width 4) ;;; Set tab width to 4 spaces.
(setq-default truncate-lines t) ;;; Long lines will not wrap.
(show-paren-mode t) ;;; Show matching parentheses.
(tool-bar-mode 0) ;;; Disable tool bar.
(winner-mode t) ;;; Enable winner mode.

;;; settings.el ends here
