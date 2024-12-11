;;; packages.el --- packages file
;;; Commentary:
;;; Packages file

;;; Code:

(use-package magit
  :ensure t
  :commands (magit-status)
  :bind (("C-x g" . magit-status)))

(use-package projectile
  :ensure t
  :diminish projectile-mode
  :config (projectile-mode)
  :bind-keymap
  ("C-c p" . projectile-command-map))

(use-package which-key
  :ensure t
  :config (which-key-mode t))

;;; packages.el ends here
