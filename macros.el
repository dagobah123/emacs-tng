;;; macros.el --- keybindings file

;;; Commentary:4cb0b3
;;; Macros file

;;; Code:

(fset 'my-huhu-macro
   (kmacro-lambda-form [?\C-s ?i ?s ?t return C-left C-delete ?h ?u ?h ?u ?\C-e right] 0 "%d"))

;;; macros.el ends here
