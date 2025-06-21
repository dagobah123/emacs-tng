;;; font.el --- font file  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Font file

;;; Code:

(cond ((string-equal system-type "windows-nt")
       (progn (setq default-font-size 220) (setq font-size 220)))
      ((string-equal system-type "gnu/linux")
       (progn (setq default-font-size 200) (setq font-size 200))))
(set-face-attribute 'default nil :height font-size)

(set-frame-font "DejaVu Sans Mono 16" nil t)

;;; font.el ends here

