;;; init.el --- init file
;;; Commentary:
;;; Load config files

;;; Code:

(defvar EMACS-HOME)
(setq EMACS-HOME (concat (getenv "PWD") "/.emacs.d"))

(setq custom--inhibit-theme-enable nil)
(add-to-list 'custom-theme-load-path "~/.emacs.d/chiaroscuro-theme.el/")

(load-file (concat EMACS-HOME "/settings.el"))
(load-file (concat EMACS-HOME "/theme/theme.el"))
(load-file (concat EMACS-HOME "/keybindings.el"))
(load-file (concat EMACS-HOME "/functions.el"))
(load-file (concat EMACS-HOME "/functions-class-overview.el"))
(load-file (concat EMACS-HOME "/package-archives.el"))
(load-file (concat EMACS-HOME "/packages.el"))

;(load-theme 'chiaroscuro t)

;;; init.el ends here
