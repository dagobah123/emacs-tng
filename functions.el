;;; functions.el --- functions file
;;; Commentary:
;;; Custom functions

;;; Code:

(defun my-grep-in-project2 (search-strings)
  "Search for multiple strings using vc-git-grep and display simplified output."
  (interactive "MEnter search strings (space-separated): ")
  (let* ((search-list (split-string search-strings " " t " "))
         (default-directory (vc-git-root default-directory))
         (grep-command (format "git --no-pager grep -n -E -i --break -e %s"
                               (mapconcat 'shell-quote-argument search-list " -e ")))
         (grep-buffer-name "*Git Grep Results*"))
    (compilation-start grep-command 'grep-mode
                       (lambda (mode-name)
                         (format "Search: %s" mode-name)))
    (with-current-buffer grep-buffer-name
      (while (search-forward-regexp (rx bol (group (1+ digit)) ":" (group (1+ not-newline)) eol) nil t)
        (replace-match (format "%s:%s" (file-name-nondirectory (match-string 2)) (match-string 1)))))))

;;; functions.el ends here
