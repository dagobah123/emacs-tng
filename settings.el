;;; settings.el --- settings file
;;; Commentary:
;;; Settings file

;;; Code:

(display-time)
(fset 'yes-or-no-p 'y-or-n-p)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(setq blink-cursor-blinks 0)
(setq confirm-kill-emacs 'y-or-n-p)
(setq dired-dwim-target t)
(setq inhibit-startup-screen t)
(setq initial-scratch-message "")
(setq ivy-read-action-function 'ivy-hydra-read-action)
(setq make-backup-files nil)
(tool-bar-mode 0)
(winner-mode t)

;;; settings.el ends here
