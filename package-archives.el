;;; package-archives.el --- package archives file
;;; Commentary:
;;; Package-Archives file

;;; Code:

(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;;; package-archives.el ends here
