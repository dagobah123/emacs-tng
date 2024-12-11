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
(setq inhibit-startup-screen t)
(setq initial-scratch-message "")
(setq make-backup-files nil)
(tool-bar-mode 0)

;;; settings.el ends here
