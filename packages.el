;;; packages.el --- packages file  -*- lexical-binding: t; -*-
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
  :delight " p"
  :config (projectile-mode) (projectile-load-known-projects))

(use-package which-key
  :ensure t
  :config (which-key-mode t)
  :delight " wk")

(use-package helm
  :ensure t
  :init
  (helm-mode t)
  (progn (setq helm-buffers-fuzzy-matching t))
  :bind
  (("M-x" . helm-M-x))
  :delight " h")

(use-package swiper
  :ensure t
  :bind
  (("C-s" . swiper)("C-r" . swiper-thing-at-point))
  :delight " s")

(use-package undo-tree
  :ensure t
  :config (global-undo-tree-mode)
  :delight " ut")

(use-package rainbow-mode
  :ensure t
  :hook (emacs-lisp-mode text-mode lisp-mode)
  :delight " r")

(use-package counsel
  :ensure t
  :config (counsel-mode)
  :delight " co")

(use-package counsel-projectile
  :ensure t
  :after (projectile counsel)
  :config
  (counsel-projectile-mode)
  :delight " pc")

(use-package ivy-hydra
  :ensure t
  :delight " ih")

(use-package powershell
  :ensure t
  :delight " po")

(use-package expand-region
  :ensure t
  :delight " er")

(use-package csharp-mode
  :ensure t
  :delight " c#")

(use-package avy
  :ensure t
  :delight " av")

(use-package iedit
  :ensure t
  :delight " ie")

(use-package olivetti
  :ensure t
  :delight " ol")

(use-package ag
  :ensure t
  :delight " ag")

(use-package drag-stuff
  :ensure t
  :delight " ds")

(use-package golden-ratio
  :ensure t
  :delight " gr")

(use-package goto-last-change
  :ensure t
  :delight " go")

(use-package counsel-fd
  :ensure t
  :delight " cf")

(use-package diredfl
  :ensure t
  :config
  (diredfl-global-mode 1)
  :delight " df")

(use-package lsp-java
  :ensure t)

(use-package lsp-ui
  :ensure t)

(use-package company
  :ensure t
  :delight " cy")

(use-package yasnippet
  :ensure t
  :delight " y")

(use-package java-snippets
  :ensure t
  :delight " js")

(use-package delight
  :ensure t)

(use-package nov
  :ensure t)

;;; packages.el ends here
