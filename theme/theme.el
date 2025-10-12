;;; theme.el --- theme file  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Theme file

;;; Code:

(setq INDEX-DEFAULT             1)
(setq INDEX-ECLIPSE             2)
(setq INDEX-COLOR-CHANGE-LIGHT  3)
(setq INDEX-HIGH-CONTRAST       4)
(setq INDEX-GRAY                5)
(setq INDEX-LOW-CHROMA          6)
(setq INDEX-BLUE                7)
(setq INDEX-NEON                8)
(setq INDEX-RED                 9)
(setq INDEX-CASABLANCA         10)
(setq INDEX-COLOR-CHANGE-DARK  11)

(setq INDEX-CHIAROSCURO 0)
(setq theme-index 0)

(defun my-reset-themes-index ()
  "Reset themes index."
  (interactive)
  (setq theme-index 0)
  (setq INDEX-CHIAROSCURO 0)
  (my-disable-themes))

(defun my-set-theme (index)
  "Set theme."
  (interactive)
  (setq theme-index index)
  (setq INDEX-CHIAROSCURO index)
  (my-toggle-themes))

(defun my-theme-down ()
  "Theme down."
  (interactive)
  (setq theme-index (- theme-index 1))
  (setq INDEX-CHIAROSCURO (- INDEX-CHIAROSCURO 1))
  (my-toggle-themes))

(defun my-theme-up ()
  "Theme up."
  (interactive)
  (setq theme-index (+ theme-index 1))
  (setq INDEX-CHIAROSCURO (+ INDEX-CHIAROSCURO 1))
  (my-toggle-themes))

(defun my-disable-themes ()
  "Disable themes."
  (interactive)
  (setq loop-index 0)
  (while (< loop-index number-of-themes)
    (disable-theme (nth loop-index themes-list))
    (setq loop-index (+ loop-index 1))))

(defun my-theme-loop ()
  "Loop."
  (interactive)
  (setq loop-index 1)
  (setq themes-list-index 0)
  (while (<= loop-index number-of-themes)
    (if (eq theme-index loop-index)
        (progn
          (load-theme (nth themes-list-index themes-list) t)
          (message "%s" (nth themes-list-index themes-list-names))))
    (setq loop-index (+ loop-index 1))
    (setq themes-list-index (+ themes-list-index 1))))

(defun my-toggle-themes ()
  "Toggle themes."
  (interactive)
  (my-disable-themes)

  (if (eq theme-index -1)
      (progn (setq theme-index number-of-themes)))

  (if (eq theme-index 0)
      (progn (message "emacs")
             (setq theme-index 0)
             (setq INDEX-CHIAROSCURO 0)))

  (my-theme-loop)

  (if (> theme-index number-of-themes)
      (progn (message "emacs")
             (setq theme-index 0)
             (setq INDEX-CHIAROSCURO 0))))

(defvar chiaroscuro-index 0 "Index representing the current theme")
(setq chiaroscuro-index 0)

(setq themes-list '(chiaroscuro
                    chiaroscuro
                    chiaroscuro
                    chiaroscuro
                    chiaroscuro
                    chiaroscuro
                    chiaroscuro
                    chiaroscuro
                    chiaroscuro
                    chiaroscuro
                    chiaroscuro))

(setq themes-list-names '("default"
                          "eclipse"
                          "color change light"
                          "high contrast"
                          "gray"
                          "low chroma"
                          "blue"
                          "neon"
                          "red"
                          "casablanca"
                          "color change dark"))

(defvar theme-index 0 "Index representing the current theme")
(setq number-of-themes (length themes-list))

;;; theme.el ends here
