;;; packages.el --- packages file
;;; Commentary:
;;; Packages file

;;; Code:

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package magit
  :ensure t
  :commands (magit-status))

(use-package projectile
  :ensure t
  :diminish projectile-mode
  :config (projectile-mode) (projectile-load-known-projects))

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
  (("C-s" . swiper)("C-r" . swiper-thing-at-point)))

(use-package undo-tree
  :ensure t
  :config (global-undo-tree-mode))

(use-package rainbow-mode
  :ensure t
  :hook (emacs-lisp-mode text-mode lisp-mode))

(use-package counsel
  :ensure t
  :config (counsel-mode))

(use-package counsel-projectile
  :ensure t
  :after (projectile counsel)
  :config
  (counsel-projectile-mode))

(use-package ivy-hydra
  :ensure t)

(use-package eglot
  :commands (eglot eglot-ensure)
  :config
  ;; Define the command to start JDTLS for Java
  (add-to-list 'eglot-server-programs
               `(java-mode . (,ECLIPSE-LS))))

(use-package powershell
  :ensure t)

(use-package expand-region
  :ensure t)

(use-package csharp-mode
  :ensure t)

(use-package avy
  :ensure t)

(use-package iedit
  :ensure t)

(use-package olivetti
  :ensure t)

(use-package ag
  :ensure t)

(use-package drag-stuff
  :ensure t)

(use-package auto-dim-other-buffers
  :ensure t)

(add-hook 'after-init-hook (lambda ()
  (when (fboundp 'auto-dim-other-buffers-mode)
    (auto-dim-other-buffers-mode t))))

(use-package golden-ratio
  :ensure t)

(use-package goto-last-change
  :ensure t)

(use-package counsel-fd
  :ensure t)

(use-package diredfl
  :ensure t
  :config
  (diredfl-global-mode 1))

;;; packages.el ends here
