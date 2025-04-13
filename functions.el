;;; functions.el --- functions file
;;; Commentary:
;;; Custom functions

;;; Code:

(defun my-grep-in-project-at-least-one-match-in-line (search-strings)
  "Search for the exact case insensitive match using vc-git-grep and display simplified output."
  (interactive "MEnter search strings (space-separated): ")
  (my-grep-in-project2 search-strings "git --no-pager grep -n -E -i --break -e %s" " -e "))

(defun my-grep-in-project-multiple-matches-in-line (search-strings)
  "Search for multiple strings using vc-git-grep and display simplified output."
  (interactive "MEnter search strings (space-separated): ")
  (my-grep-in-project2 search-strings "git --no-pager grep -n -E -i --all-match -e %s" " --and -e "))

(defun my-grep-in-project-exact (search-string)
  "Search for the exact case insensitive match using vc-git-grep and display simplified output."
  (interactive "sExact search string: ")
  (let* ((quoted (shell-quote-argument (format "%s" search-string)))
         (grep-command (concat "git --no-pager grep -n -E -i --break "
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

;;; functions.el ends here
