;;; init.el --- init file
;;; Commentary:
;;; Load config files

;;; Code:

(defvar EMACS-HOME)
(setq EMACS-HOME (concat (getenv "PWD") "/.emacs.d"))

(load-file (concat EMACS-HOME "/settings.el"))
(load-file (concat EMACS-HOME "/functions.el"))

;;; init.el ends here
