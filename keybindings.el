;;; keybindings.el --- keybindings file
;;; Commentary:
;;; Keybindings file

;;; Code:

(defvar-keymap my-prefix-map-rings
  :doc "My custom prefix keymap"
  "m" #'helm-all-mark-rings
  "k" #'helm-show-kill-ring)

(defvar-keymap my-prefix-map
  :doc "My custom prefix keymap"
  "l" #'recenter-top-bottom
  "b" #'bookmark-bmenu-list
  "s" #'my-grep-in-project2
  "i" #'imenu
  "c" #'counsel-M-x
  "r" my-prefix-map-rings)

(keymap-set global-map "C-l" my-prefix-map)

;;; keybindings.el ends here
