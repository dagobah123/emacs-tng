;;; lsp.el --- lsp file  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Lsp file

;;; Code:

(defvar lsp-java-java-path)
(setq lsp-java-java-path "/home/computer/software/jdk-21.0.2/bin/java")

(defun my-lsp-off ()
  "Turn off LSP and remove the hook for Java buffers4."
  (interactive)
  (message "LSP off")
  (lsp-shutdown-workspace)
  (remove-hook 'java-mode-hook #'lsp))

(defun my-lsp-on ()
  "Turn on LSP and add the hook for Java buffers."
  (interactive)
  (message "LSP on")
  (lsp)
  (add-hook 'java-mode-hook #'lsp nil t))

;;; lsp.el ends here


