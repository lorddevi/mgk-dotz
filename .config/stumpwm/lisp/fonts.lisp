;; vim: set ft=lisp :
;; -*-lisp-*-

(defvar *font-size* 12 "Default font size")

(defun get-hostname ()
  "Get the hostname and trim all whitespace, including newlines."
  (string-trim '(#\Space #\Newline #\Return #\Tab)
               (run-shell-command "hostname" t)))

(defun set-font-based-on-hostname ()
  "Set the font size based on the hostname."
  (let ((hostname (get-hostname)))
    (setf *font-size*
          (cond
            ((string-equal hostname "orthanc") 16)
            ((string-equal hostname "angband") 16)
            ((string-equal hostname "mairon") 34)
            ((string-equal hostname "barad-dur") 16)
            (t 12)))))

(defun set-font-on-startup ()
	(set-font-based-on-hostname)
	(let ((font-string (format nil "-Adobe-Courier-Bold-r-Normal-*-~D-*-100-100-*-*-*-*" *font-size*)))
    (set-font font-string)))

(add-hook *start-hook* #'set-font-on-startup)
