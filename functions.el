;;; functions.el --- functions file
;;; Commentary:
;;; Custom functions

;;; Code:

(defun my-grep-in-project-at-least-one-match-in-line (search-strings)
  "Search space-separated, case insensitive, at least one match per line."
  (interactive "MSearch: (space-separated, case insensitive, at least one match per line, use \\ to escape): ")
  (my-grep-in-project2 search-strings "git --no-pager grep -n -E -i --break -e %s" " -e "))

(defun my-grep-in-project-multiple-matches-in-line (search-strings)
  "Search space-separated, case insensitive, all matches per line."
  (interactive "MSearch: (space-separated, case insensitive, all matches per line, use \\ to escape): ")
  (my-grep-in-project2 search-strings "git --no-pager grep -n -E -i --all-match -e %s" " --and -e "))

(defun my-grep-in-project-exact (search-string)
  "Search case insensitive, exact match, string can contain spaces."
  (interactive "sSearch: (case insensitive, exact match, string can contain spaces, use \\ to escape) ")
  (let* ((quoted (shell-quote-argument (format "%s" search-string)))
         (grep-command (concat "git --no-pager grep -n -E -i --break "
                             quoted " "
                             (projectile-project-root))))
    (compilation-start grep-command 'grep-mode)))

(defun my-grep-in-project2 (search-strings grep-string grep-concat)
  "Basic git grep search."
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
  (back-to-indentation)
  (recenter))

(defun my-scroll-up-center ()
  "Scroll up."
  (interactive)
  (previous-line 1)
  (back-to-indentation)
  (recenter))

(defun my-project-status ()
  "Project status."
  (interactive)
  (counsel-projectile-org-agenda nil "t")
  (delete-other-windows)
  (split-window-vertically)
  (magit-status))

(defun my-buffers-list ()
  "Display a list of buffers alphabetically (excluding those starting with '*') and open the selected buffer."
  (interactive)
  (let ((buffers (mapcar #'buffer-name (buffer-list))))
    ;; Exclude buffers starting with '*'
    ;;;(setq buffers (seq-filter (lambda (buf) (not (string-prefix-p " *" buf))) buffers))
    ;;;(setq buffers (seq-filter (lambda (buf) (not (string-prefix-p "*" buf))) buffers))
    ;; Sort the remaining buffers alphabetically
    ;;;(setq buffers (sort buffers #'string<))
    (let ((chosen-buffer (completing-read "Select buffer: " buffers)))
      (when chosen-buffer
        (switch-to-buffer chosen-buffer)))))

;;; functions.el ends here
