;; vim: set ft=lisp :
;; -*-lisp-*-


;;;;;;;;;;
;; Misc
;;;;;;;;;;
;;;; Read some doc
(define-key *root-map* (kbd "c") "exec kitty")
(define-key *root-map* (kbd "C") "exec alacritty")
;; Browse somewhere
(define-key *root-map* (kbd "b") "colon1 exec firefox http://")
;; Ssh somewhere
(define-key *root-map* (kbd "C-s") "colon1 exec kitty -e ssh ")

;;;;;;;;;;
;; Emacs
;;;;;;;;;;
;;(define-key *root-map* (kbd "s-e") "decide-on-emacsclient")
;;(define-key *root-map* (kbd "C-e") "decide-on-emacsclient")
(define-key *root-map* (kbd "e") "decide-on-emacsclient")
;;(define-key *root-map* (kbd "e") "run-or-raise-emacs")
;;(define-key *root-map* (kbd "s-E") "emacsclient-launch")
;;(define-key *root-map* (kbd "C-E") "emacsclient-launch")
(define-key *root-map* (kbd "E") "emacsclient-launch")
