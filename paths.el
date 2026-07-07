;;; paths.el --- paths file  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Machine-specific paths used by the rest of the configuration.

;;; Code:

(defvar HOME-DIRECTORY
  (cond ((string-equal system-type "windows-nt")
         (getenv "USERPROFILE")) ;;; Get home directory in Windows
        ((string-equal system-type "gnu/linux")
         (getenv "HOME")))       ;;; Get home directory in Linux
  "The user's home directory.")

(defvar ECLIPSE-LS
  (concat HOME-DIRECTORY "/software/jdt-language-server-1.43.0-202412191447/bin/jdtls")
  "Path to the Eclipse JDT language server executable.")

;;; paths.el ends here
