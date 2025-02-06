;;; keybindings.el --- keybindings file
;;; Commentary:
;;; Keybindings file

;;; Code:

(defvar-keymap my-prefix-map-theme
  :doc "Theme keymap"
  "1" #'default
  "2" #'eclipse
  "3" #'console-light
  "4" #'color-change-light
  "5" #'high-contrast
  "6" #'gray
  "7" #'low-chroma
  "8" #'blue
  "9" #'neon
  "c" #'casablanca
  "d" #'color-change-dark
  "l" #'console-light
  "r" #'red)

(defvar-keymap my-prefix-map-search
  :doc "Search keymap"
  "g" #'my-grep-in-project2)

(defvar-keymap my-prefix-map-code
  :doc "Code keymap"
  "c" #'my-class-overview)

(defvar-keymap my-prefix-map-rings
  :doc "Rings keymap"
  "m" #'helm-all-mark-rings
  "k" #'helm-show-kill-ring)

(defvar-keymap my-prefix-map-org
  :doc "Org keymap"
  "c" #'org-capture
  "a" #'org-agenda)

(defvar-keymap my-prefix-map
  :doc "Main keymap"
  "b" #'bookmark-bmenu-list
  "c" my-prefix-map-code
  "h" #'hydra-master/body
  "i" #'imenu
  "l" #'recenter-top-bottom
  "o" my-prefix-map-org
  "r" my-prefix-map-rings
  "s" my-prefix-map-search
  "t" my-prefix-map-theme)

(keymap-set global-map "C-l" my-prefix-map)

;;; helper functions

(defun default ()
  (interactive)
  (my-set-theme INDEX-DEFAULT))

(defun eclipse ()
  (interactive)
  (my-set-theme INDEX-ECLIPSE))

(defun console-light ()
  (interactive)
  (my-set-theme INDEX-CONSOLE-LIGHT))

(defun color-change-light ()
  (interactive)
  (my-set-theme INDEX-COLOR-CHANGE-LIGHT))

(defun high-contrast ()
  (interactive)
  (my-set-theme INDEX-HIGH-CONTRAST))

(defun gray ()
  (interactive)
  (my-set-theme INDEX-GRAY))

(defun low-chroma ()
  (interactive)
  (my-set-theme INDEX-LOW-CHROMA))

(defun blue ()
  (interactive)
  (my-set-theme INDEX-BLUE))

(defun neon ()
  (interactive)
  (my-set-theme INDEX-NEON))

(defun color-change-dark ()
  (interactive)
  (my-set-theme INDEX-COLOR-CHANGE-DARK))

(defun red ()
  (interactive)
  (my-set-theme INDEX-RED))

(defun casablanca ()
  (interactive)
  (my-set-theme INDEX-CASABLANCA))

(defun color-change-dark ()
  (interactive)
  (my-set-theme INDEX-COLOR-CHANGE-DARK))

;;; keybindings.el ends here
