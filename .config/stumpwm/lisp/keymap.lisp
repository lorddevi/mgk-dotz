;; vim: set ft=lisp :
;; -*-lisp-*-


;;;;;;;;;;
;; Misc
;;;;;;;;;;
;; Terminals
(define-key *root-map* (kbd "c") "exec kitty")
(define-key *root-map* (kbd "C") "exec alacritty")
;; Browser (Firefox
(define-key *root-map* (kbd "b") "exec firefox")
(define-key *root-map* (kbd "B") "colon1 exec firefox http://")
;; Ssh somewhere
(define-key *root-map* (kbd "C-s") "colon1 exec kitty -e ssh ")

;;;;;;;;;;
;; Emacs
;;;;;;;;;;
;; Launch emacsclient if not already loaded.  Otherwise, jump it and
;; raise it.
(define-key *root-map* (kbd "e") "decide-on-emacsclient")
;; Create a brand new emacsclient session if one is already running.
(define-key *root-map* (kbd "E") "emacsclient-launch")
