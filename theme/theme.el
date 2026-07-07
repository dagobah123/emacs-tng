;;; theme.el --- theme switching  -*- lexical-binding: t; -*-
;;; Commentary:
;;; State and commands for cycling and selecting the chiaroscuro theme
;;; variants.  The single custom theme `chiaroscuro' reads
;;; `INDEX-CHIAROSCURO' every time it is loaded and picks its palette
;;; accordingly, so switching variants means: disable the theme, set
;;; the index, load the theme again.

;;; Code:

;; Indices of the theme variants.  Index 0 means "no theme" (plain
;; Emacs colors).  The order matches `themes-list-names' below and the
;; dispatch table in chiaroscuro-theme.el.
(defvar INDEX-DEFAULT             1)
(defvar INDEX-ECLIPSE             2)
(defvar INDEX-COLOR-CHANGE-LIGHT  3)
(defvar INDEX-HIGH-CONTRAST       4)
(defvar INDEX-GRAY                5)
(defvar INDEX-LOW-CHROMA          6)
(defvar INDEX-BLUE                7)
(defvar INDEX-NEON                8)
(defvar INDEX-RED                 9)
(defvar INDEX-CASABLANCA         10)
(defvar INDEX-COLOR-CHANGE-DARK  11)
(defvar INDEX-ELSA               12)
(defvar INDEX-UBUNTU             13)

(defvar theme-index 0
  "Index of the currently active theme variant (0 = no theme).")

(defvar INDEX-CHIAROSCURO 0
  "Copy of `theme-index' read by chiaroscuro-theme.el while it loads.")

(defvar themes-list-names '("default"
                            "eclipse"
                            "color change light"
                            "high contrast"
                            "gray"
                            "low chroma"
                            "blue"
                            "neon"
                            "red"
                            "casablanca"
                            "color change dark"
                            "elsa"
                            "ubuntu")
  "Display names of the theme variants, in index order.")

(defvar number-of-themes (length themes-list-names)
  "Number of available theme variants.")

(defun my-reset-themes-index ()
  "Reset themes index and disable the theme."
  (interactive)
  (setq theme-index 0)
  (setq INDEX-CHIAROSCURO 0)
  (my-disable-themes))

(defun my-set-theme (index)
  "Set theme variant INDEX and activate it."
  (interactive)
  (setq theme-index index)
  (setq INDEX-CHIAROSCURO index)
  (my-toggle-themes))

(defun my-theme-down ()
  "Switch to the previous theme variant."
  (interactive)
  (setq theme-index (- theme-index 1))
  (setq INDEX-CHIAROSCURO (- INDEX-CHIAROSCURO 1))
  (my-toggle-themes))

(defun my-theme-up ()
  "Switch to the next theme variant."
  (interactive)
  (setq theme-index (+ theme-index 1))
  (setq INDEX-CHIAROSCURO (+ INDEX-CHIAROSCURO 1))
  (my-toggle-themes))

(defun my-disable-themes ()
  "Disable the chiaroscuro theme."
  (interactive)
  (disable-theme 'chiaroscuro))

(defun my-theme-loop ()
  "Load the theme variant selected by `theme-index', if any."
  (interactive)
  (when (and (>= theme-index 1)
             (<= theme-index number-of-themes))
    (load-theme 'chiaroscuro t)
    (message "%s" (nth (1- theme-index) themes-list-names))))

(defun my-toggle-themes ()
  "Activate the theme variant selected by `theme-index'.
Wraps around at both ends of the variant list; index 0 leaves the
plain Emacs colors active."
  (interactive)
  (my-disable-themes)

  (when (eq theme-index -1)
    (setq theme-index number-of-themes))

  (when (eq theme-index 0)
    (message "emacs")
    (setq INDEX-CHIAROSCURO 0))

  (my-theme-loop)

  (when (> theme-index number-of-themes)
    (message "emacs")
    (setq theme-index 0)
    (setq INDEX-CHIAROSCURO 0)))

;;; theme.el ends here
