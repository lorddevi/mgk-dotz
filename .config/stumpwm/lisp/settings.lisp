;; vim: set ft=lisp :
;; -*-lisp-*-

;;; Basic Settings
(setf *window-format* "%m%s%50t")
(setf *mode-line-background-color* (car *colors*)
      *mode-line-foreground-color* (car (last *colors*))
      *mode-line-timeout* 1)

(setf *message-window-gravity* :center
      *window-border-style* :thin
      *message-window-padding* 3
      *maxsize-border-width* 2
      *normal-border-width* 2
      *transient-border-width* 2
      stumpwm::*float-window-border* 1
      stumpwm::*float-window-title-height* 1)

;; Focus Follow Mouse
(setf *mouse-focus-policy* :sloppy)

;;; Completion
;; ;; Show all completions from start
;; (setf *input-completion-show-empty* nil)
;; ;; keep completions open even when one is selected
;; (setf *input-completion-style* (make-input-completion-style-unambiguous))
(setf *input-window-gravity* :center
      ;; TODO determin why this appears above
      *message-window-input-gravity* :left)

(setf *input-completion-show-empty* t)

;; Remember commands and offers orderless completion
;; https://github.com/landakram/stumpwm-prescient
(ql:quickload :stumpwm-prescient)
(setf *input-refine-candidates-fn* 'stumpwm-prescient:refine-input)
