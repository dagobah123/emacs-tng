;;; init.el --- init file  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Load config files

;;; Code:

(defvar EMACS-HOME
  (directory-file-name
   (file-name-directory (or load-file-name
                            (expand-file-name user-emacs-directory))))
  "Directory containing this Emacs configuration.")

;; Allow `custom-theme-set-faces' to take effect immediately when a
;; theme file is loaded; chiaroscuro-theme.el relies on this.
(setq custom--inhibit-theme-enable nil)
(add-to-list 'custom-theme-load-path "~/.emacs.d/chiaroscuro-theme.el/")

;; Load order matters: paths and theme state first, package setup
;; before anything that configures packages, keybindings last so all
;; commands they reference are defined.
(dolist (file '("paths.el"
                "org.el"
                "theme/theme.el"
                "functions.el"
                "functions-class-overview.el"
                "package-archives.el"
                "packages.el"
                "dired.el"
                "hydra.el"
                "font.el"
                "shell.el"
                "macros.el"
                "settings.el"
                "lsp.el"
                "keybindings.el"))
  (load-file (expand-file-name file EMACS-HOME)))

;;; init.el ends here
