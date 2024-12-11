;;; packages.el --- packages file
;;; Commentary:
;;; Packages file

;;; Code:

(use-package magit
  :ensure t
  :commands (magit-status)
  :bind (("C-x g" . magit-status)))

;;; packages.el ends here
