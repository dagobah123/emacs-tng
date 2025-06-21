;;; dired.el --- dired file  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Dired file

;;; Code:

;; https://www.gnu.org/software/emacs/manual/html_node/dired-x/Installation.html
(with-eval-after-load 'dired
  (require 'dired-x)
  ;; Set dired-x global variables here.  For example:
  ;; (setq dired-x-hands-off-my-keys nil)
  )
(add-hook 'dired-mode-hook
          (lambda ()
            ;; Set dired-x buffer-local variables here.  For example:
            (dired-omit-mode 1)
            ))

(setq dired-dwim-target t)
(setq dired-omit-files (concat dired-omit-files "\\|\\.~undo-tree~$"))

;;; dired.el ends here
