;;; custom.el --- custom file
;;; Commentary:
;;; Custom file

;;; Code:


(defhydra hydra-custom (:hint nil :color red)

  "
  Custom

  ^Custom^
  ^^^^^---------------------
  _1_: Custom
  ^ ^
  "

  ("1" info)

  ("q" nil "Quit" :color blue))


;;; custom.el ends here
