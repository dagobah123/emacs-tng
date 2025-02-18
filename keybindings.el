;;; keybindings.el --- keybindings file
;;; Commentary:
;;; Keybindings file

;;; Code:

;;; Theme keymap
(defvar my-prefix-map-theme (make-sparse-keymap) "Theme keymap")
(define-key my-prefix-map-theme (kbd "1") #'default)
(define-key my-prefix-map-theme (kbd "2") #'eclipse)
(define-key my-prefix-map-theme (kbd "3") #'console-light)
(define-key my-prefix-map-theme (kbd "4") #'color-change-light)
(define-key my-prefix-map-theme (kbd "5") #'high-contrast)
(define-key my-prefix-map-theme (kbd "6") #'gray)
(define-key my-prefix-map-theme (kbd "7") #'low-chroma)
(define-key my-prefix-map-theme (kbd "8") #'blue)
(define-key my-prefix-map-theme (kbd "9") #'neon)
(define-key my-prefix-map-theme (kbd "c") #'casablanca)
(define-key my-prefix-map-theme (kbd "d") #'color-change-dark)
(define-key my-prefix-map-theme (kbd "l") #'console-light)
(define-key my-prefix-map-theme (kbd "r") #'red)

;;; Search keymap
(defvar my-prefix-map-search (make-sparse-keymap) "Search keymap")
(define-key my-prefix-map-search (kbd "g") #'my-grep-in-project2)

;;; Code keymap
(defvar my-prefix-map-code (make-sparse-keymap) "Code keymap")
(define-key my-prefix-map-code (kbd "c") #'my-class-overview)

;;; Rings keymap
(defvar my-prefix-map-rings (make-sparse-keymap) "Rings keymap")
(define-key my-prefix-map-rings (kbd "m") #'helm-all-mark-rings)
(define-key my-prefix-map-rings (kbd "k") #'helm-show-kill-ring)

;;; Org keymap
(defvar my-prefix-map-org (make-sparse-keymap) "Org keymap")
(define-key my-prefix-map-org (kbd "c") #'org-capture)
(define-key my-prefix-map-org (kbd "a") #'org-agenda)

;;; Main keymap
(defvar my-prefix-map (make-sparse-keymap) "Main keymap")
(define-key my-prefix-map (kbd "b") #'bookmark-bmenu-list)
(define-key my-prefix-map (kbd "c") my-prefix-map-code)
(define-key my-prefix-map (kbd "h") #'hydra-master/body)
(define-key my-prefix-map (kbd "i") #'imenu)
(define-key my-prefix-map (kbd "l") #'recenter-top-bottom)
(define-key my-prefix-map (kbd "o") my-prefix-map-org)
(define-key my-prefix-map (kbd "r") my-prefix-map-rings)
(define-key my-prefix-map (kbd "s") my-prefix-map-search)
(define-key my-prefix-map (kbd "t") my-prefix-map-theme)

;; Bind main keymap to "C-l"
(global-set-key (kbd "C-l") my-prefix-map)

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
