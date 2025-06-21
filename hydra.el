;;; hydra.el --- hydra file  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Hydra file

;;; Code:

(defhydra hydra-registers (:hint nil :color red)

  "
  Registers

  ^Registers^
  ^^^^^---------------------
  _1_: Point to register
  _2_: Jump to register
  _3_: Copy to register
  _4_: Insert register
  _5_: List
  _6_: Helm
  ^ ^
  "

  ("1" point-to-register)
  ("2" jump-to-register)
  ("3" copy-to-register)
  ("4" insert-register)
  ("5" list-registers)
  ("6" (helm-register))

  ("q" nil "Quit" :color blue))

(defhydra hydra-master (:color blue)
  ""
  ("c" hydra-custom/body "Custom")
  ("r" hydra-registers/body "Registers")
  ("q" nil "Quit" :color red))

;;; hydra.el ends here
