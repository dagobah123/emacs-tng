;;; org.el --- org file  -*- lexical-binding: t; -*-
;;; Commentary:
;;; org mode settings

;;; Code:

(setq org-todo-keywords '((sequence "TODO" "IN-PROGRESS" "|" "DONE")))

(defvar org-capture-templates)
(defvar org-agenda-files)

(setq org-capture-templates
      '(("t" "Tasks" entry (file+headline "~/source/org-mode/agenda/tasks.org" "Tasks") "* TODO %?")
	("r" "Remember" entry (file+headline "~/source/org-mode/agenda/remember.org" "Remember") "* TODO %?")))

(setq org-agenda-files (list "~/source/org-mode/agenda" "~/source/emacs-tng"))

(setq org-tags-column 0)

;;; org.el ends here
