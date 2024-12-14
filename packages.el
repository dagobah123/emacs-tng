;;; packages.el --- packages file
;;; Commentary:
;;; Packages file

;;; Code:

(use-package magit
  :ensure t
  :commands (magit-status)
  :bind (("C-l v" . magit-status)))

(use-package projectile
  :ensure t
  :diminish projectile-mode
  :config (projectile-mode)
  :bind-keymap
  ("C-l p" . projectile-command-map))

(use-package which-key
  :ensure t
  :config (which-key-mode t))

(use-package helm
  :ensure t
  :init
  (helm-mode t)
  (progn (setq helm-buffers-fuzzy-matching t))
  :bind
  (("M-x" . helm-M-x)))

(use-package swiper
  :ensure t
  :bind
  (("C-s" . swiper)))

(use-package undo-tree
  :ensure t
  :config (global-undo-tree-mode))

(use-package rainbow-mode
  :ensure t
  :hook (emacs-lisp-mode text-mode lisp-mode))

;;; packages.el ends here
