;;; keybindings.el --- keybindings file
;;; Commentary:
;;; Keybindings file

;;; Code:

(defvar my-prefix-map (make-sparse-keymap) "My custom prefix keymap")
(define-key global-map (kbd "C-l") my-prefix-map)
(define-key my-prefix-map (kbd "l") 'recenter-top-bottom)
(define-key my-prefix-map (kbd "b") 'bookmark-bmenu-list)
(define-key my-prefix-map (kbd "s") 'my-grep-in-project2)

;;; keybindings.el ends here
