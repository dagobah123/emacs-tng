;;; paths.el --- paths file  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Load config files

;;; Code:

(defvar HOME-DIRECTORY)

(cond ((string-equal system-type "windows-nt")
       (progn (setq HOME-DIRECTORY (getenv "HOME")))) ;;; Get home directory in Linux
      ((string-equal system-type "gnu/linux")
       (progn (setq HOME-DIRECTORY (getenv "USERPROFILE"))))) ;;; Get home directory in Windows

(defvar ECLIPSE-LS)
(setq ECLIPSE-LS (concat HOME-DIRECTORY "/software/jdt-language-server-1.43.0-202412191447/bin/jdtls"))

;;; paths.el ends here
