;;; keybindings.el --- keybindings file
;;; Commentary:
;;; Keybindings file

;;; Code:

;;; Theme keymap
(defvar my-prefix-map-theme (make-sparse-keymap) "Theme keymap")
(define-key my-prefix-map-theme (kbd "D") #'color-change-dark)
(define-key my-prefix-map-theme (kbd "L") #'color-change-light)
(define-key my-prefix-map-theme (kbd "b") #'blue)
(define-key my-prefix-map-theme (kbd "c") #'casablanca)
(define-key my-prefix-map-theme (kbd "d") #'default)
(define-key my-prefix-map-theme (kbd "e") #'eclipse)
(define-key my-prefix-map-theme (kbd "g") #'gray)
(define-key my-prefix-map-theme (kbd "h") #'high-contrast)
(define-key my-prefix-map-theme (kbd "l") #'low-chroma)
(define-key my-prefix-map-theme (kbd "n") #'neon)
(define-key my-prefix-map-theme (kbd "r") #'red)

;;; Search keymap
(defvar my-prefix-map-search (make-sparse-keymap) "Search keymap")
(define-key my-prefix-map-search (kbd "g") #'my-grep-in-project2)
(define-key my-prefix-map-search (kbd "o") #'occur)

;;; Editor keymap
(defvar my-prefix-map-editor (make-sparse-keymap) "Editor keymap")
(define-key my-prefix-map-editor (kbd "c") #'my-class-overview)
(define-key my-prefix-map-editor (kbd "i") #'imenu)
(define-key my-prefix-map-editor (kbd "a") #'back-to-indentation)
(define-key my-prefix-map-editor (kbd "l") #'display-line-numbers-mode)
(define-key my-prefix-map-editor (kbd "w") #'whitespace-mode)

;;; Projectile keymap
(defvar my-prefix-map-projectile (make-sparse-keymap) "Projectile keymap")
(define-key my-prefix-map-projectile (kbd "f") #'counsel-projectile-find-file)
(define-key my-prefix-map-projectile (kbd "p") #'counsel-projectile-switch-project)

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
(define-key my-prefix-map (kbd "C-l") #'er/expand-region)
(define-key my-prefix-map (kbd "b") #'helm-bookmarks)
(define-key my-prefix-map (kbd "e") my-prefix-map-editor)
(define-key my-prefix-map (kbd "h") #'hydra-master/body)
(define-key my-prefix-map (kbd "l") #'recenter-top-bottom)
(define-key my-prefix-map (kbd "o") my-prefix-map-org)
(define-key my-prefix-map (kbd "p") my-prefix-map-projectile)
(define-key my-prefix-map (kbd "r") my-prefix-map-rings)
(define-key my-prefix-map (kbd "s") my-prefix-map-search)
(define-key my-prefix-map (kbd "t") my-prefix-map-theme)

;; Bind main keymap to "C-l"
(global-set-key (kbd "C-l") my-prefix-map)

(global-set-key (kbd "C-x C-b") 'switch-to-buffer)

;;; helper functions

(defun default ()
  (interactive)
  (my-set-theme INDEX-DEFAULT))

(defun eclipse ()
  (interactive)
  (my-set-theme INDEX-ECLIPSE))

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
