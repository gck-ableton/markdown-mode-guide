;; Support code for generating screenshots on macOS from within Emacs
;;
;; Jason Blevins <jrblevin@sdf.org>
;;
;; screencapture arguments:
;;    -o      no shadow
;;    -x      no sounds
;;    -tpng   generate a PNG file
;;    -T1     one second delay
;;    -W      capture window
;;    -l      window id

;; Set up a consistent look for screenshots.
(setq-default line-spacing 0.25)
(set-face-attribute 'default nil :family "Fira Code" :height 160)
(set-face-attribute 'fixed-pitch nil :family "Source Code Pro")
(set-face-attribute 'variable-pitch nil :family "Fira Sans")
(dolist (theme custom-enabled-themes)
  (disable-theme theme))
(load-theme 'sanityinc-tomorrow-day)
(set-frame-size (selected-frame) 80 35)

;; Load markdown-mode
(load-library "markdown-mode.el")

(defconst markdown-guide-images-dir "~/work/markdown-mode-guide/manuscript/images/")

(defun markdown-guide-screenshot (&optional filename)
  (interactive)
  (unless filename
    (setq filename (format-time-string
                    (concat markdown-guide-images-dir
                            "screenshot-%Y-%02m-%02dT%02H.%02M.%02S.png")
                    (current-time))))
  (let ((window-id
         (do-applescript "tell app \"Emacs\" to id of window 1")))
    (shell-command (format "screencapture -o -x -tpng -T1 -W -l%d %s" window-id filename))))

(global-set-key (kbd "C-c s") #'markdown-guide-screenshot)
