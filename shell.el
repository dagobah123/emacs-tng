;;; shell.el --- shell file  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Shell file

;;; Code:

(add-hook 'compilation-filter-hook
          (lambda () (ansi-color-apply-on-region (point-min) (point-max))))

;;; shell.el ends here
