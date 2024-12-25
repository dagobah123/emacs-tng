;;; paths.el --- paths file
;;; Commentary:
;;; Load config files

;;; Code:

(defvar PATH)
(setq PATH (getenv "PWD"))

(defvar ECLIPSE-LS)
(setq ECLIPSE-LS (concat PATH "/software/jdt-language-server-1.43.0-202412191447/bin/jdtls"))

(message "XXXXXXXXXXXXXXXXX")
(message ECLIPSE-LS)

;;; paths.el ends here
