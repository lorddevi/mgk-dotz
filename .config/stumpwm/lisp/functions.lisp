;; vim: set ft=lisp :
;; -*-lisp-*-

;;;;;;;;;;
;; Interactive Prompt
;;;;;;;;;;
;; Prompt the user for an interactive command. The first arg is an optional initial contents.
(defcommand colon1 (&optional (initial "")) (:rest)
  (let ((cmd (read-one-line (current-screen) ": " :initial-input initial)))
    (when cmd
      (eval-command cmd t))))

;;;;;;;;;;
;; EMACS
;;;;;;;;;;
;; The below function leverages run-or-raise-prefer-group to either launch
;; emacs, if it is not already running, or else focus the Icecat window, and
;; successive calls will cycle through multiple emacs windows/windows if more
;; than one emacs window exists. This is extremely useful as it’s much less
;; cognitively-tasking than figuring out which window number emacs currently
;; is associated with.
(defun run-or-raise-prefer-group (cmd win-cls)
  "If there are windows in the same class, cycle in those. Otherwise call
run-or-raise with group search t."
  (let ((windows (group-windows (current-group))))
    (if (member win-cls (mapcar #'window-class windows) :test #'string-equal)
	(run-or-raise cmd `(:class ,win-cls) nil T)
	(run-or-raise cmd `(:class ,win-cls) T T))))

(defcommand run-or-raise-emacsclient () ()
  (run-or-raise-prefer-group "emacs" "Emacs"))

(defcommand decide-on-emacsclient () ()
 (if (equal (run-shell-command "pgrep \"emacsclient\"" t) "")
     (run-shell-command "emacsclient -c")
     (run-or-raise-emacsclient)))

(defcommand emacsclient-launch () ()
  (run-shell-command "emacsclient -c"))
