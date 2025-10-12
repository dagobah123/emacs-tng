;;; functions.el --- functions file  -*- lexical-binding: t; -*-
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

(defun my-grep-in-project-at-least-one-match-in-line-case-sensitive (search-strings)
  "Search space-separated, case sensitive, at least one match per line."
  (interactive "MSearch: (space-separated, case insensitive, at least one match per line, use \\ to escape): ")
  (my-grep-in-project2 search-strings "git --no-pager grep -n -E --break -e %s" " -e "))

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

(defun my-copy-line-at-point ()
  "Copy line at point."
  (interactive)
  (save-excursion
    (let ((begin (line-beginning-position))
          (end (line-end-position)))
      (copy-region-as-kill begin end)))
  (message "Copied line."))

(defun my-get-filename ()
  "Get file name."
  (interactive)
  (dired-jump)
  (dired-copy-filename-as-kill)
  (kill-this-buffer))

(defvar regexp-class ".*class.*")
(defvar regexp-member "public.*;\\|protected.*;\\|private.*;")

(defun my-goto-class ()
  "Go to class."
  (interactive)
  (beginning-of-buffer)
  (re-search-forward regexp-class nil t)
  (evil-first-non-blank))

(defun my-goto-member ()
  "Go to member."
  (interactive)
  (beginning-of-buffer)
  (re-search-forward regexp-member nil t)
  (evil-first-non-blank))

(defun my-find-file-at-point-in-project ()
  "Find file at point in project."
  (interactive)
  (subword-mode 0)
  (save-excursion
    (let ((end (progn (right-word) (point)))
          (beg (progn (backward-word) (point))))
      (copy-region-as-kill beg end)

      (find-file (my-find-file-recursively (projectile-project-root) (concat (current-kill 0) ".java")))))
  (subword-mode t))

(defun my-find-file-recursively (directory filename)
  "Recursively search for FILENAME in DIRECTORY and its subdirectories, ignoring hidden files and directories."
  (let ((files (directory-files directory t))
        (result nil))
    (dolist (file files)
      (let ((file-name (file-name-nondirectory file)))
        (unless (string-prefix-p "." file-name)  ; Ignore hidden files/dirs
          (if (file-directory-p file)
              (when (not (member file-name '("." "..")))
                (setq found (my-find-file-recursively file filename))
                (when found
                  (setq result found)))
            (when (string= file-name filename)
              (setq result file))))))
    result))

(defun my-theme-default ()
  (interactive)
  (my-set-theme INDEX-COLOR-CHANGE-DARK)
  (my-theme-up))

(defun my-theme-eclipse ()
  (interactive)
  (my-set-theme INDEX-ECLIPSE))

(defun my-theme-color-change-light ()
  (interactive)
  (my-set-theme INDEX-COLOR-CHANGE-LIGHT))

(defun my-theme-high-contrast ()
  (interactive)
  (my-set-theme INDEX-HIGH-CONTRAST))

(defun my-theme-gray ()
  (interactive)
  (my-set-theme INDEX-GRAY))

(defun my-theme-low-chroma ()
  (interactive)
  (my-set-theme INDEX-LOW-CHROMA))

(defun my-theme-blue ()
  (interactive)
  (my-set-theme INDEX-BLUE))

(defun my-theme-neon ()
  (interactive)
  (my-set-theme INDEX-NEON))

(defun my-theme-color-change-dark ()
  (interactive)
  (my-set-theme INDEX-COLOR-CHANGE-DARK))

(defun my-theme-red ()
  (interactive)
  (my-set-theme INDEX-RED))

(defun my-theme-casablanca ()
  (interactive)
  (my-set-theme INDEX-CASABLANCA))

(defun color-change-dark ()
  (interactive)
  (my-set-theme INDEX-COLOR-CHANGE-DARK))

;;; functions.el ends here
