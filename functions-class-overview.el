;;; functions-class-overview.el --- functions-class-overview file
;;; Commentary:
;;; Custom functions

;;; Code:

(defun my-class-overview ()
  "Parse all classes of a project and print the class overview."
  (interactive)
  (let ((project-root (projectile-project-root)))
    (if project-root
        (let ((file-list (my-class-overview-find-files-in-project project-root "java")))
          (message "my-class-overview() Length of the list: %d" (length file-list))

          (my-class-overview-print-data-in-new-buffer file-list))
      (message "Not in a Projectile project or Projectile is not active."))))

(defun my-class-overview-find-files-in-project (directory extension)
  "List files with a specific extension in all subdirectories of DIRECTORY."
  (let ((file-list '()))
    (dolist (file (directory-files-recursively directory (concat "\\." extension "$")))
      (when (file-regular-p file)
        (push file file-list)))
    (message "my-class-overview-find-files-in-project() Length of the list: %d" (length file-list))
    file-list))

(defun my-class-overview-parse-java-file-for-members (file-path)
  "Parse a Java file to extract member types (fields, methods) with variable names."
  (with-temp-buffer
    (insert-file-contents file-path)
    (goto-char (point-min))
    (let ((result ""))
      (while (re-search-forward "^\\s-*\\b\\(?:private\\|public\\|protected\\)\\b[^;\n]*;" nil t)
        (setq result (concat result (buffer-substring-no-properties
                                     (line-beginning-position)
                                     (line-end-position))
                             "\n")))
      result)))

(defun my-class-overview-print-data-in-new-buffer (file-list)
  "Print DATA in a new buffer."
  (let ((new-buffer (get-buffer-create "*ClassOverview*"))
        (content ""))
    (with-current-buffer new-buffer
      (erase-buffer)
      (cl-loop for element in file-list
               for index from 1
               do
               (setq content (concat content (format "%d: %s\n" index (file-name-sans-extension (file-name-nondirectory element)) (my-class-oveview-get-java-parents element))))
               (dolist (element2 (my-class-oveview-get-java-parents element))
                 ; Parents
                 (if element2
                     (progn
                       (setq content (concat content (format "--------------------------------------------------------------------------------\n")))
                       (setq content (concat content (format "    %s\n" element2)))
                       ))
                 ; Members
                 (if (my-class-overview-parse-java-file-for-members element)
                     (progn
                       (setq content (concat content (format "--------------------------------------------------------------------------------\n")))
                       (setq content (concat content (my-class-overview-parse-java-file-for-members element)))
                       ))
                 )
               (setq content (concat content (format "________________________________________________________________________________\n\n")))
               )
      )
    (switch-to-buffer new-buffer)
    (insert content)))

(defun my-class-overview-test ()
  "Test function"
  (interactive)
  (my-class-overview-parse-java-file-for-members "/home/computer/source/lsp_sandbox/src/main/java/org/sandbox/observerpattern/ObserverA.java"))

(defun my-class-oveview-get-java-parents (file-path)
  "Parse a Java file to extract its parent classes and implemented interfaces."
  (with-temp-buffer
    (insert-file-contents file-path)
    (goto-char (point-min))
    (let (parents)
      (while (re-search-forward "\\bextends\\s-+\\(\\(?:[[:alnum:]_$]+\\.\\)*[[:alnum:]_$]+\\)\\b" nil t)
        (setq parents (cons (match-string 1) parents)))
      (goto-char (point-min)) ;; Reset cursor position
      (while (re-search-forward "\\bimplements\\s-+\\(\\(?:[[:alnum:]_$]+\\.\\)*[[:alnum:]_$]+\\)\\b" nil t)
        (setq parents (cons (match-string 1) parents)))
      parents)))

;;; functions-class-overview.el ends here
