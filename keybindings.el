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
(define-key my-prefix-map-search (kbd "1") #'my-grep-in-project-at-least-one-match-in-line)
(define-key my-prefix-map-search (kbd "2") #'my-grep-in-project-multiple-matches-in-line)
(define-key my-prefix-map-search (kbd "3") #'my-grep-in-project-exact)
(define-key my-prefix-map-search (kbd "a") #'ag)
(define-key my-prefix-map-search (kbd "c") #'counsel-projectile-git-grep)
(define-key my-prefix-map-search (kbd "o") #'occur)
(define-key my-prefix-map-search (kbd "s") #'swiper-all)

;;; Editor keymap
(defvar my-prefix-map-editor (make-sparse-keymap) "Editor keymap")
(define-key my-prefix-map-editor (kbd "<left>") #'scroll-right)
(define-key my-prefix-map-editor (kbd "<right>") #'scroll-left)
(define-key my-prefix-map-editor (kbd "L") #'my-magit-log)
(define-key my-prefix-map-editor (kbd "b") #'magit-log-buffer-file)
(define-key my-prefix-map-editor (kbd "c") #'my-class-overview)
(define-key my-prefix-map-editor (kbd "d") #'my-duplicate-line)
(define-key my-prefix-map-editor (kbd "e") #'iedit)
(define-key my-prefix-map-editor (kbd "i") #'imenu)
(define-key my-prefix-map-editor (kbd "l") #'display-line-numbers-mode)
(define-key my-prefix-map-editor (kbd "m") #'my-magit)
(define-key my-prefix-map-editor (kbd "n") #'my-new-line)
(define-key my-prefix-map-editor (kbd "o") #'olivetti-mode)
(define-key my-prefix-map-editor (kbd "w") #'whitespace-mode)

;;; Projectile keymap
(defvar my-prefix-map-projectile (make-sparse-keymap) "Projectile keymap")
(define-key my-prefix-map-projectile (kbd "c") #'counsel-projectile-org-capture)
(define-key my-prefix-map-projectile (kbd "d") #'ivy-dispatching-done)
(define-key my-prefix-map-projectile (kbd "i") #'projectile-ibuffer)
(define-key my-prefix-map-projectile (kbd "s") #'my-project-status)
(define-key my-prefix-map-projectile (kbd "t") #'counsel-projectile-org-agenda)

;;; Rings keymap
(defvar my-prefix-map-rings (make-sparse-keymap) "Rings keymap")
(define-key my-prefix-map-rings (kbd "k") #'helm-show-kill-ring)
(define-key my-prefix-map-rings (kbd "m") #'helm-all-mark-rings)

;;; Org keymap
(defvar my-prefix-map-org (make-sparse-keymap) "Org keymap")
(define-key my-prefix-map-org (kbd "a") #'org-agenda)
(define-key my-prefix-map-org (kbd "c") #'org-capture)

;;; Main keymap
(defvar my-prefix-map (make-sparse-keymap) "Main keymap")
(define-key my-prefix-map (kbd "C-l") #'er/expand-region)
(define-key my-prefix-map (kbd "b") #'helm-bookmarks)
(define-key my-prefix-map (kbd "e") my-prefix-map-editor)
(define-key my-prefix-map (kbd "h") #'hydra-master/body)
(define-key my-prefix-map (kbd "l") #'recenter-top-bottom)
(define-key my-prefix-map (kbd "o") my-prefix-map-org)
(define-key my-prefix-map (kbd "p") my-prefix-map-projectile)
(define-key my-prefix-map (kbd "q") 'goto-last-change)
(define-key my-prefix-map (kbd "r") my-prefix-map-rings)
(define-key my-prefix-map (kbd "s") my-prefix-map-search)
(define-key my-prefix-map (kbd "t") my-prefix-map-theme)

;; Bind main keymap to "C-l"
(global-set-key (kbd "C-l") my-prefix-map)

(global-set-key (kbd "<C-down>") 'my-scroll-down-center)
(global-set-key (kbd "<C-next>") 'projectile-next-project-buffer)
(global-set-key (kbd "<C-prior>") 'projectile-previous-project-buffer)
(global-set-key (kbd "<C-up>") 'my-scroll-up-center)
(global-set-key (kbd "<M-down>") 'windmove-down)
(global-set-key (kbd "<M-left>") 'windmove-left)
(global-set-key (kbd "<M-right>") 'windmove-right)
(global-set-key (kbd "<M-up>") 'windmove-up)
(global-set-key (kbd "C-,") 'avy-goto-char-2)
(global-set-key (kbd "C-<") 'dabbrev-completion)
(global-set-key (kbd "C-M-,") #'(lambda() (interactive) (scroll-right 10)))
(global-set-key (kbd "C-M-.") #'(lambda() (interactive) (scroll-left 10)))
(global-set-key (kbd "C-b") 'counsel-projectile-switch-to-buffer)
(global-set-key (kbd "C-f") 'counsel-projectile-find-file)
(global-set-key (kbd "C-i") 'ivy-dispatching-call)
(global-set-key (kbd "C-p") 'counsel-projectile-switch-project)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "M-H") 'sort-lines)
(global-set-key (kbd "M-a") 'drag-stuff-up)
(global-set-key (kbd "M-z") 'drag-stuff-down)

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
