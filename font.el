;;; font.el --- font file
;;; Commentary:
;;; Font file

;;; Code:

(cond ((string-equal system-type "windows-nt")
       (progn (setq default-font-size 220) (setq font-size 220)))
      ((string-equal system-type "gnu/linux")
       (progn (setq default-font-size 200) (setq font-size 200))))
(set-face-attribute 'default nil :height font-size)

;;; font.el ends here

