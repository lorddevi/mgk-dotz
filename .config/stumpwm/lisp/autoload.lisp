;; vim: set ft=lisp :
;; -*-lisp-*-

;;;; Autostart apps
(run-shell-command "picom")
(run-shell-command "reset-kb")
(run-shell-command "emacs --daemon")

;; Wallpaper stuff
;; Function to run the background setting script
(defun run-bg-script ()
  (run-shell-command "~/.local/bin/mgk-bg"))

;; Set up a timer to call run-bg-script every 10 seconds
(run-with-timer 10 10 'run-bg-script)
