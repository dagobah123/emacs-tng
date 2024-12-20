;;; keybindings.el --- keybindings file
;;; Commentary:
;;; Keybindings file

;;; Code:

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

(defvar-keymap my-prefix-map
  :doc "Main keymap"
  "l" #'recenter-top-bottom
  "b" #'bookmark-bmenu-list
  "s" my-prefix-map-search
  "i" #'imenu
  "c" my-prefix-map-code
  "r" my-prefix-map-rings)

(keymap-set global-map "C-l" my-prefix-map)

;;; keybindings.el ends here
