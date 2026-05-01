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

;;;(use-package gptel
;;;  :ensure t
;;;  :config
;;;  (setq gptel-model "gemini-2.5-flash")
;;;  (setq gptel-backend (gptel-make-gemini "Gemini"
;;;                        :key ""
;;;                        :stream t)))

(use-package gptel
  :ensure t
  :config
  ;;;(gptel-make-gemini "Gemini"
  ;;;  :key ""
  ;;;  :stream t)
  (let ((ollama-bknd (gptel-make-ollama "Ollama-Local"
                       :host "localhost:11434"
                       :models '("qwen2.5-coder")
                       :stream t)))
    (setq gptel-backend ollama-bknd
          gptel-model "qwen2.5-coder")))

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
  ;; 1. Set the default model for Ollama
  (setq aidermacs-args '("--model" "ollama/qwen2.5-coder"))
  
  ;; 2. Configure the backend to use Ollama's API endpoint
  ;; Aider uses LiteLLM under the hood for Ollama support
  (setenv "OLLAMA_API_BASE" "http://127.0.0.1:11434")

  ;; 3. (Optional) UI Customizations
  (setq aidermacs-backend 'vterm) ; Recommended for the best terminal experience
  (setq aidermacs-auto-save-buffers t))

(add-to-list 'process-environment "OLLAMA_API_BASE=http://127.0.0.1:11434")

(setq aidermacs-args '("--model" "ollama/qwen2.5-coder" "--edit-format" "diff"))

(use-package vterm
    :ensure t)

;;;(use-package ellama
;;;  :ensure t
;;;  :bind ("C-c e" . ellama)
;;;  ;; send last message in chat buffer with C-c C-c
;;;  :hook (org-ctrl-c-ctrl-c-hook . ellama-chat-send-last-message)
;;;  :init
;;;  ;; setup key bindings
;;;  ;; (setopt ellama-keymap-prefix "C-c e")
;;;  ;; language you want ellama to translate to
;;;  (setopt ellama-language "German")
;;;  ;; could be llm-openai for example
;;;  (require 'llm-ollama)
;;;  (setopt ellama-provider
;;;  	  (make-llm-ollama
;;;  	   ;; this model should be pulled to use it
;;;  	   ;; value should be the same as you print in terminal during pull
;;;  	   :chat-model "llama3:8b-instruct-q8_0"
;;;  	   :embedding-model "nomic-embed-text"
;;;  	   :default-chat-non-standard-params '(("num_ctx" . 8192))))
;;;  (setopt ellama-summarization-provider
;;;  	  (make-llm-ollama
;;;  	   :chat-model "qwen2.5:3b"
;;;  	   :embedding-model "nomic-embed-text"
;;;  	   :default-chat-non-standard-params '(("num_ctx" . 32768))))
;;;  (setopt ellama-coding-provider
;;;  	  (make-llm-ollama
;;;  	   :chat-model "qwen2.5-coder:3b"
;;;  	   :embedding-model "nomic-embed-text"
;;;  	   :default-chat-non-standard-params '(("num_ctx" . 32768))))
;;;  ;; Predefined llm providers for interactive switching.
;;;  ;; You shouldn't add ollama providers here - it can be selected interactively
;;;  ;; without it. It is just example.
;;;  (setopt ellama-providers
;;;  	  '(("zephyr" . (make-llm-ollama
;;;  			 :chat-model "zephyr:7b-beta-q6_K"
;;;  			 :embedding-model "zephyr:7b-beta-q6_K"))
;;;  	    ("mistral" . (make-llm-ollama
;;;  			  :chat-model "mistral:7b-instruct-v0.2-q6_K"
;;;  			  :embedding-model "mistral:7b-instruct-v0.2-q6_K"))
;;;  	    ("mixtral" . (make-llm-ollama
;;;  			  :chat-model "mixtral:8x7b-instruct-v0.1-q3_K_M-4k"
;;;  			  :embedding-model "mixtral:8x7b-instruct-v0.1-q3_K_M-4k"))))
;;;  ;; Naming new sessions with llm
;;;  (setopt ellama-naming-provider
;;;  	  (make-llm-ollama
;;;  	   :chat-model "llama3:8b-instruct-q8_0"
;;;  	   :embedding-model "nomic-embed-text"
;;;  	   :default-chat-non-standard-params '(("stop" . ("\n")))))
;;;  (setopt ellama-naming-scheme 'ellama-generate-name-by-llm)
;;;  ;; Translation llm provider
;;;  (setopt ellama-translation-provider
;;;  	  (make-llm-ollama
;;;  	   :chat-model "qwen2.5:3b"
;;;  	   :embedding-model "nomic-embed-text"
;;;  	   :default-chat-non-standard-params
;;;  	   '(("num_ctx" . 32768))))
;;;  (setopt ellama-extraction-provider (make-llm-ollama
;;;  				      :chat-model "qwen2.5-coder:7b-instruct-q8_0"
;;;  				      :embedding-model "nomic-embed-text"
;;;  				      :default-chat-non-standard-params
;;;  				      '(("num_ctx" . 32768))))
;;;  ;; customize display buffer behaviour
;;;  ;; see ~(info "(elisp) Buffer Display Action Functions")~
;;;  (setopt ellama-chat-display-action-function #'display-buffer-full-frame)
;;;  (setopt ellama-instant-display-action-function #'display-buffer-at-bottom)
;;;  :config
;;;  ;; show ellama context in header line in all buffers
;;;  (ellama-context-header-line-global-mode +1)
;;;  ;; show ellama session id in header line in all buffers
;;;  (ellama-session-header-line-global-mode +1)
;;;  ;; handle scrolling events
;;;  (advice-add 'pixel-scroll-precision :before #'ellama-disable-scroll)
;;;  (advice-add 'end-of-buffer :after #'ellama-enable-scroll))

;;; packages.el ends here
