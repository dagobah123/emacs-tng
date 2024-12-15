;;; keybindings.el --- keybindings file
;;; Commentary:
;;; Keybindings file

;;; Code:

(defvar my-prefix-map (make-sparse-keymap) "My custom prefix keymap")
(define-key global-map (kbd "C-l") my-prefix-map)
(define-key my-prefix-map (kbd "l") 'recenter-top-bottom)
(define-key my-prefix-map (kbd "b") 'bookmark-bmenu-list)
(define-key my-prefix-map (kbd "s") 'my-grep-in-project2)

(defvar my-prefix-map-ring (make-sparse-keymap) "My custom prefix keymap")
(define-key my-prefix-map (kbd "r") my-prefix-map-ring)
(define-key my-prefix-map-ring (kbd "m") 'helm-all-mark-rings)
(define-key my-prefix-map-ring (kbd "k") 'helm-show-kill-ring)

;;; keybindings.el ends here
