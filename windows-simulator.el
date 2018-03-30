;;; windows-simulator.el --- simulate the world's most popular desktop OS -*- lexical-binding: t -*-

;; Copyright (c) 2018 Chris Bowdon
;;
;; Author: Chris Bowdon
;; URL: https://github.com/cbowdon/windows-simulator.el
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3
;;
;; Created: February 13, 2018
;; Modified: February 13, 2018
;; Version: 1.1.0
;; Keywords: games
;; Package-Requires: ((emacs "25"))
;;
;;; Commentary:
;; The world's most popular desktop OS, in Emacs!
;;
;; I was not in a great frame of mind when I wrote this.

;;; Code:

(defvar windows-simulator--old-bg-color (face-attribute 'default :background)
  "Your Emacs frame's background color before `windows-simulator' fucks it up.")

(defun windows-simulator ()
  "Simulates what it is like to run Windows as your OS.

Kill this buffer to get your old theme, cursor and modeline back.
Sorry, window layout is not preserved."
  (interactive)
  (with-current-buffer (get-buffer-create "*windows-simulator*")
    (delete-other-windows)
    (set-frame-parameter (selected-frame) 'alpha (list 100 100))
    (set-background-color "blue")
    (insert
     (propertize "\n" 'face '(:height 4.0))
     (propertize " :(\n" 'face '(:foreground "white" :height 8.0))
     (propertize "    Your PC ran into a problem that it couldn't handle,\n" 'face '(:foreground "white" :height 2.0))
     (propertize "    and now it needs to restart.\n" 'face '(:foreground "white" :height 2.0)))
    (setq mode-line-format nil)
    (add-hook 'kill-buffer-hook #'windows-simulator-reset-theme)
    (switch-to-buffer (current-buffer))
    (setq cursor-type nil)
    (unless (eq (frame-parameter (selected-frame) 'fullscreen) 'fullboth)
      (toggle-frame-fullscreen))))

(defun windows-simulator-reset-theme ()
  "Reset your theme bg colour to what it was before running `windows-simulator'."
  (interactive)
  (setq cursor-type t)
  (set-background-color windows-simulator--old-bg-color)
  (remove-hook 'kill-buffer-hook #'windows-simulator-reset-theme))

(provide 'windows-simulator)
;;; windows-simulator.el ends here
