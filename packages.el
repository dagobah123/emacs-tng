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
  (setq helm-buffers-fuzzy-matching t)
  :bind
  (("M-x" . helm-M-x))
  :delight " h")

(use-package swiper
  :ensure t
  :bind
  (("C-s" . swiper)("C-r" . swiper-thing-at-point))
  :delight " s")

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
  :defer t
  :delight " po")

(use-package expand-region
  :ensure t
  :delight " er")

(use-package csharp-mode
  :ensure t
  :defer t
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

;; lsp-java is declared in lsp.el together with its configuration.

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
  :ensure t
  :defer t)

(use-package gptel
  :ensure t
  :config
  (let ((ollama-bknd (gptel-make-ollama "Ollama-Local"
                       :host "localhost:11434"
                       :models '("qwen2.5-coder:7b")
                       :stream t)))
    (setq gptel-backend ollama-bknd
          gptel-model "qwen2.5-coder:7b")))

(use-package ollama-buddy
  :ensure t
  :bind
  ("C-c o" . ollama-buddy-role-transient-menu)
  ("C-c O" . ollama-buddy-transient-menu))

(use-package chatgpt-shell
  :ensure t
  :custom
  ;; This tells the package where to find your local Ollama instance
  (chatgpt-shell-ollama-api-url-base "http://localhost:11434"))

(use-package ellama
  :ensure t
  :bind ("C-c e" . ellama)
  ;; send last message in chat buffer with C-c C-c
  :hook (org-ctrl-c-ctrl-c-hook . ellama-chat-send-last-message)
  :init (setopt ellama-auto-scroll t)
  :config
  ;; show ellama context in header line in all buffers
  (ellama-context-header-line-global-mode +1)
  ;; show ellama session id in header line in all buffers
  (ellama-session-header-line-global-mode +1))

(use-package aidermacs
  :ensure t
  :bind (("C-c a" . aidermacs-transient-menu)) ; Quick access to all aider commands
  :config
  ;; Set the default model for Ollama
  (setq aidermacs-args '("--model" "ollama/qwen2.5-coder"))
  ;; UI customizations
  (setq aidermacs-backend 'vterm) ; Recommended for the best terminal experience
  (setq aidermacs-auto-save-buffers t))

;; Aider uses LiteLLM under the hood for Ollama support; set the
;; endpoint at startup so every subprocess inherits it.
(setenv "OLLAMA_API_BASE" "http://127.0.0.1:11434")

(use-package vterm
  :ensure t)

;;; packages.el ends here
