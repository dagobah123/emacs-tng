;;; chiaroscuro-theme.el --- Theme consisting of multiple themes  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(load-file "~/.emacs.d/theme/common/default.el")

;;; load light or dark diff colors
(if (>= INDEX-CHIAROSCURO INDEX-HIGH-CONTRAST)
    (load-file "~/.emacs.d/theme/common/diff-dark.el")
  (load-file "~/.emacs.d/theme/common/diff-light.el"))

;;; dark themes start here
(if (>= INDEX-CHIAROSCURO INDEX-LOW-CHROMA)
    (load-file "~/.emacs.d/theme/common/dark.el")
  (load-file "~/.emacs.d/theme/common/light.el"))

(setq theme-map
      `((,INDEX-ECLIPSE . "~/.emacs.d/theme/light/eclipse.el")
        (,INDEX-COLOR-CHANGE-LIGHT . "~/.emacs.d/theme/color-changer/color-changer.el")
        (,INDEX-HIGH-CONTRAST . "~/.emacs.d/theme/light/high-contrast.el")
        (,INDEX-GRAY . "~/.emacs.d/theme/light/gray.el")
        (,INDEX-LOW-CHROMA . "~/.emacs.d/theme/dark/low-chroma.el")
        (,INDEX-BLUE . "~/.emacs.d/theme/dark/blue.el")
        (,INDEX-NEON . "~/.emacs.d/theme/dark/neon.el")
        (,INDEX-RED . "~/.emacs.d/theme/dark/red.el")
        (,INDEX-CASABLANCA . "~/.emacs.d/theme/dark/casablanca.el")
        (,INDEX-UBUNTU . "~/.emacs.d/theme/dark/ubuntu.el")
        (,INDEX-COLOR-CHANGE-DARK . "~/.emacs.d/theme/color-changer/color-changer.el")
        (,INDEX-ELSA . "~/.emacs.d/theme/dark/elsa.el")
        (,INDEX-UBUNTU . "~/.emacs.d/theme/dark/ubuntu.el")))

(let ((theme-file (assoc-default INDEX-CHIAROSCURO theme-map)))
  (when (and theme-file (> INDEX-CHIAROSCURO INDEX-DEFAULT))
    (load-file theme-file)))

(deftheme chiaroscuro)

(custom-theme-set-faces 'chiaroscuro

(set-face-attribute 'default nil :foreground text-normal :background background)
(set-face-attribute 'hl-line nil :foreground text-hl)
(set-face-attribute 'font-lock-bracket-face nil :foreground text-font-lock-bracket-face)
(set-face-attribute 'font-lock-builtin-face nil :foreground text-font-lock-builtin-face)
(set-face-attribute 'font-lock-comment-delimiter-face nil :foreground text-font-lock-comment-delimiter-face)
(set-face-attribute 'font-lock-comment-face nil :foreground text-font-lock-comment-face)
(set-face-attribute 'font-lock-constant-face nil :foreground text-font-lock-constant-face)
(set-face-attribute 'font-lock-delimiter-face nil :foreground text-font-lock-delimiter-face)
(set-face-attribute 'font-lock-doc-face nil :foreground text-font-lock-doc-face)
(set-face-attribute 'font-lock-doc-markup-face nil :foreground text-font-lock-doc-markup-face)
(set-face-attribute 'font-lock-escape-face nil :foreground text-font-lock-escape-face)
(set-face-attribute 'font-lock-function-call-face nil :foreground text-font-lock-function-call-face)
(set-face-attribute 'font-lock-function-name-face nil :foreground text-font-lock-function-name-face :bold t)
(set-face-attribute 'font-lock-keyword-face nil :foreground text-font-lock-keyword-face)
(set-face-attribute 'font-lock-misc-punctuation-face nil :foreground text-font-lock-misc-punctuation-face)
(set-face-attribute 'font-lock-negation-char-face nil :foreground text-font-lock-negation-char-face)
(set-face-attribute 'font-lock-number-face nil :foreground text-font-lock-number-face)
(set-face-attribute 'font-lock-operator-face nil :foreground text-font-lock-operator-face)
(set-face-attribute 'font-lock-preprocessor-face nil :foreground text-font-lock-preprocessor-face)
(set-face-attribute 'font-lock-property-name-face nil :foreground text-font-lock-property-name-face)
(set-face-attribute 'font-lock-property-use-face nil :foreground text-font-lock-property-use-face)
(set-face-attribute 'font-lock-punctuation-face nil :foreground text-font-lock-punctuation-face)
(set-face-attribute 'font-lock-regexp-face nil :foreground text-font-lock-regexp-face)
(set-face-attribute 'font-lock-regexp-grouping-backslash nil :foreground text-font-lock-regexp-grouping-backslash)
(set-face-attribute 'font-lock-regexp-grouping-construct nil :foreground text-font-lock-regexp-grouping-construct)
(set-face-attribute 'font-lock-string-face nil :foreground text-font-lock-string-face)
(set-face-attribute 'font-lock-type-face nil :foreground text-font-lock-type-face)
(set-face-attribute 'font-lock-variable-name-face nil :foreground text-font-lock-variable-name-face :bold t)
(set-face-attribute 'font-lock-variable-use-face nil :foreground text-font-lock-variable-use-face)
(set-face-attribute 'font-lock-warning-face nil :foreground text-font-lock-warning-face)
(set-face-attribute 'mode-line nil :foreground text-mode-line :background background-mode-line :box `(:line-width 8 :color ,background-mode-line))
(set-face-attribute 'mode-line-inactive nil :foreground text-mode-line-inactive :background background-mode-line-inactive :box `(:line-width 8 :color ,background-mode-line-inactive))

)

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
           (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'chiaroscuro)

;;; chiaroscuro-theme.el ends here
