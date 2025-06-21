;;; macros.el --- keybindings file  -*- lexical-binding: t; -*-

;;; Commentary:4cb0b3
;;; Macros file

;;; Code:

(fset 'my-csharp-macro
   (kmacro-lambda-form [?\C-s ?. backspace ?/ backspace ?\\ ?. return return] 0 "%d"))

;;; macros.el ends here
