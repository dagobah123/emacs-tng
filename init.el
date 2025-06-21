;;; init.el --- init file  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Load config files

;;; Code:

(defvar EMACS-HOME)
(setq EMACS-HOME (concat default-directory ".emacs.d"))

(setq custom--inhibit-theme-enable nil)
(add-to-list 'custom-theme-load-path "~/.emacs.d/chiaroscuro-theme.el/")

(load-file (concat EMACS-HOME "/paths.el"))
(load-file (concat EMACS-HOME "/org.el"))
(load-file (concat EMACS-HOME "/theme/theme.el"))
(load-file (concat EMACS-HOME "/functions.el"))
(load-file (concat EMACS-HOME "/functions-class-overview.el"))
(load-file (concat EMACS-HOME "/package-archives.el"))
(load-file (concat EMACS-HOME "/packages.el"))
(load-file (concat EMACS-HOME "/dired.el"))
(load-file (concat EMACS-HOME "/hydra.el"))
(load-file (concat EMACS-HOME "/font.el"))
(load-file (concat EMACS-HOME "/custom.el"))
(load-file (concat EMACS-HOME "/macros.el"))
(load-file (concat EMACS-HOME "/settings.el"))
(load-file (concat EMACS-HOME "/lsp.el"))
(load-file (concat EMACS-HOME "/keybindings.el"))

;;; init.el ends here
