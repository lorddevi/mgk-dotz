;; vim: set ft=lisp :
;; -*-lisp-*-
(in-package :stumpwm)

(ql:quickload :clx-truetype)
(load-module "ttf-fonts")

(defvar *font-size* 16 "Default font size")

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
            ((string-equal hostname "mairon") 24)
            ((string-equal hostname "barad-dur") 16)
            (t 16)))))

(defun set-font-safely ()
  "Attempt to set the JetBrainsMono NF font, with error handling."
  (handler-case
      (progn
        (set-font (make-instance 'xft:font 
                                 :family "JetBrainsMono NF" 
                                 :subfamily "Regular" 
                                 :size *font-size* 
                                 :antialias t))
        (message "JetBrainsMono NF font set successfully."))
    (error (c)
      (message "Error setting JetBrainsMono NF font: ~A" c)
      (message "Falling back to default font")
      (ignore-errors
        (set-font "-misc-fixed-medium-r-normal--13-120-75-75-c-70-iso8859-1"))
      (message "Default font set."))))

(defun set-font-on-startup ()
  (handler-case
      (progn
        (message "Starting font setup...")
        (set-font-based-on-hostname)
        (message "Hostname-based font size: ~A" *font-size*)
        (setq clx-truetype::*font-dirs*
              (append (list (namestring (merge-pathnames ".local/share/fonts" (user-homedir-pathname))))
                      clx-truetype::*font-dirs*))
        (xft:cache-fonts)
        (set-font-safely)
        (message "Font setup complete."))
    (error (c)
      (message "Critical error in set-font-on-startup: ~A" c))))

;; Add the function to the start hook
(add-hook *start-hook* #'set-font-on-startup)

;; Immediate execution for testing
(set-font-on-startup)

;; Message window font
;;(set-font "-xos4-terminus-medium-r-normal--14-140-72-72-c-80-iso8859-15")
;;(set-font "-*-lucida-*-*-*-*-34-*-*-*-*-*-*-*")
;; My fav:
;;(set-font "-Misc-Fixed-Medium-R-Normal--20-200-75-75-C-100-ISO10646-1")

;;  (set-font (make-instance 'xft:font
;;                           :family "JetBrainsMono NF"
;;                           :subfamily "Regular"
;;                           :size *font-size*
;;                           :antialias t)))

