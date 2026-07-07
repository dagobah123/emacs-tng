;;; macros.el --- macros file  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Macros file

;;; Code:

(fset 'my-csharp-macro
   (kmacro-lambda-form [?\C-s ?. backspace ?/ backspace ?\\ ?. return return] 0 "%d"))

;;; macros.el ends here
