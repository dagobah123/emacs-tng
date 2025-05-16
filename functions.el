;;; functions.el --- functions file
;;; Commentary:
;;; Custom functions

;;; Code:

(defun my-grep-in-project-at-least-one-match-in-line (search-strings)
  "Search for the exact case insensitive match using vc-git-grep and display simplified output."
  (interactive "MEnter search strings (space-separated): ")
  (my-grep-in-project2 search-strings "git --no-pager grep -n -E --break -e %s" " -e "))

(defun my-grep-in-project-multiple-matches-in-line (search-strings)
  "Search for multiple strings using vc-git-grep and display simplified output."
  (interactive "MEnter search strings (space-separated): ")
  (my-grep-in-project2 search-strings "git --no-pager grep -n -E --all-match -e %s" " --and -e "))

(defun my-grep-in-project-exact (search-string)
  "Search for the exact case insensitive match using vc-git-grep and display simplified output."
  (interactive "sExact search string: ")
  (let* ((quoted (shell-quote-argument (format "%s" search-string)))
         (grep-command (concat "git --no-pager grep -n -E --break "
                             quoted " "
                             (projectile-project-root))))
    (compilation-start grep-command 'grep-mode)))

(defun my-grep-in-project2 (search-strings grep-string grep-concat)
  "Search for multiple strings using vc-git-grep and display simplified output."
  (let* ((search-list (split-string search-strings " " t " "))
         (default-directory (projectile-project-root default-directory))
         (grep-command (format grep-string
                               (mapconcat 'shell-quote-argument search-list grep-concat)))
         (grep-buffer-name "*Git Grep Results*"))
    (compilation-start grep-command 'grep-mode
                       (lambda (mode-name)
                         (format "Search: %s" mode-name)))
    (with-current-buffer grep-buffer-name
      (while (search-forward-regexp (rx bol (group (1+ digit)) ":" (group (1+ not-newline)) eol) nil t)
        (replace-match (format "%s:%s" (file-name-nondirectory (match-string 2)) (match-string 1)))))))

(defun my-duplicate-line ()
  "Duplicate line at point."
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank))

(defun my-new-line ()
  "Create a new line below the current line."
  (interactive)
  (move-end-of-line nil)
  (newline)
  (c-indent-line-or-region))

(defun my-format-csharp ()
  "Format csharp buffer."
  (interactive)
  (while (re-search-forward ")" nil t)
    (newline)))

(defun my-magit ()
  "Open magit in one window."
  (interactive)
  (projectile-vc)
  (delete-other-windows))

(defun my-magit-log ()
  "Open magit log in one window."
  (interactive)
  (magit-log-current nil nil)
  (delete-other-windows))

(defun my-scroll-down-center ()
  "Scroll down."
  (interactive)
  (next-line 1)
  (recenter))

(defun my-scroll-up-center ()
  "Scroll up."
  (interactive)
  (previous-line 1)
  (recenter))

;;; functions.el ends here
