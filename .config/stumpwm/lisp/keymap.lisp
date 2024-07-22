;; vim: set ft=lisp :
;; -*-lisp-*-

;; {{{ <clear keymaps>
;; Clear keymaps so we can re-build them ourselves.
(setf *root-map* (make-sparse-keymap))
(setf *groups-map* (make-sparse-keymap))
(setf *group-top-map* (make-sparse-keymap))
(setf *group-root-map* (make-sparse-keymap))
(setf *tile-group-root-map* (make-sparse-keymap))
(setf *exchange-window-map* (make-sparse-keymap))
(setf *root-map* (make-sparse-keymap))
;; }}} </clear keymaps>

;; {{{ <root map>
;; {{{  <applications>
(define-key *root-map* (kbd "c") "exec kitty")
(define-key *root-map* (kbd "C") "exec alacritty")
(define-key *root-map* (kbd "b") "exec firefox")
;;(define-key *root-map* (kbd "B") "colon1 exec firefox http://")
;;(define-key *root-map* (kbd "s") "colon1 exec kitty -e ssh ")
;; Launch emacsclient if not already loaded.  Otherwise, jump it and
;; raise it.
(define-key *root-map* (kbd "e") "decide-on-emacsclient")
;; Create a brand new emacsclient session if one is already running.
(define-key *root-map* (kbd "E") "emacsclient-launch")
;; }}}  </applications>
;; {{{  <navigation>
;; Navigate focus by direction.
(define-key *root-map* (kbd "s-l") "move-focus right")
(define-key *root-map* (kbd "s-h") "move-focus left")
(define-key *root-map* (kbd "s-k") "move-focus up")
(define-key *root-map* (kbd "s-j") "move-focus down")
;; List windows in current frame.
(define-key *root-map* (kbd "\'") "frame-windowlist")
;; List windows.
(define-key *root-map* (kbd "\"") "windowlist")
;; Jump between windows in current frame.
(define-key *root-map* (kbd "C-t") "pull-hidden-other")
;; Next window in current frame.
(define-key *root-map* (kbd "n") "pull-hidden-next")
;; Previous window in current frame.
(define-key *root-map* (kbd "p") "pull-hidden-previous")
;; Jump to frame using number overlay.
(define-key *root-map* (kbd "f") "fselect")
;; Jump to most recent urgent window.
(define-key *root-map* (kbd "C-u") "next-urgent")
;; Lay out all windows in a grid and present numbers on them for the
;; user to select which window he wants to bring into focus and zoom
;; in to.
(define-key *root-map* (kbd "RET") "expose")
;; Select window by number.
;; TODO: Can I have these window numbers start at 1 instead of 0
;; somehow?
(define-key *root-map* (kbd "1") "select-window-by-number 1")
(define-key *root-map* (kbd "2") "select-window-by-number 2")
(define-key *root-map* (kbd "3") "select-window-by-number 3")
(define-key *root-map* (kbd "4") "select-window-by-number 4")
(define-key *root-map* (kbd "5") "select-window-by-number 5")
(define-key *root-map* (kbd "6") "select-window-by-number 6")
(define-key *root-map* (kbd "7") "select-window-by-number 7")
(define-key *root-map* (kbd "8") "select-window-by-number 8")
(define-key *root-map* (kbd "9") "select-window-by-number 9")
(define-key *root-map* (kbd "0") "select-window-by-number 0")
;; }}}  </navigation>
;; {{{  <window management>
;; Pull window by number.
(define-key *root-map* (kbd "1") "pull-window-by-number 1")
(define-key *root-map* (kbd "2") "pull-window-by-number 2")
(define-key *root-map* (kbd "3") "pull-window-by-number 3")
(define-key *root-map* (kbd "4") "pull-window-by-number 4")
(define-key *root-map* (kbd "5") "pull-window-by-number 5")
(define-key *root-map* (kbd "6") "pull-window-by-number 6")
(define-key *root-map* (kbd "7") "pull-window-by-number 7")
(define-key *root-map* (kbd "8") "pull-window-by-number 8")
(define-key *root-map* (kbd "9") "pull-window-by-number 9")
(define-key *root-map* (kbd "0") "pull-window-by-number 0")
;; Move window by direction.
(define-key *root-map* (kbd "M-l") "move-window right")
(define-key *root-map* (kbd "M-h") "move-window left")
(define-key *root-map* (kbd "M-k") "move-window up")
(define-key *root-map* (kbd "M-j") "move-window down")
;; }}}  </window management>
;; {{{  <frame and split management>
;; Vertical Split.
(define-key *root-map* (kbd "s") "vsplit")
;; Horizontal Split.
(define-key *root-map* (kbd "S") "hsplit")
;; Remove currently active frame from split.
(define-key *root-map* (kbd "R") "remove-split")
;; Resize frames.
(define-key *root-map* (kbd "r") "iresize")
;; Clear current frame of windows.
(define-key *root-map* (kbd "-") "fclear")
;; Place current window (apply placement rules to it.)
(define-key *root-map* (kbd "P") "place-current-window")
;; Place all windows (apply placement rules to it.)
(define-key *root-map* (kbd "W") "place-existing-windows")
;; }}}  </frame and split management>
;; {{{  <utility commands>
;; Exec any shell command.
(define-key *root-map* (kbd "!") "exec")
;; Abort.
(define-key *root-map* (kbd "C-g") "abort")
;; Send ESC.  Needed for some apps on occassion.
(define-key *root-map* (kbd "t") "send-escape")
;; Colon
(define-key *root-map* (kbd ";") "colon")
;; Eval a lisp expression using the active stump repl.
(define-key *root-map* (kbd ":") "eval")
;; Last message.  View previous messages from stump.
(define-key *root-map* (kbd "m") "last-message")
;; Quit with confirmation.
(define-key *root-map* (kbd "q") "quit-confirm")
;; Quit without confirmation.
(define-key *root-map* (kbd "Q") "quit")
;; Delete window cleanly.
(define-key *root-map* (kbd "k") "delete-window")
;; Kill window entirely.
(define-key *root-map* (kbd "K") "kill-window")
;; Go fullscreen with current window.
(define-key *root-map* (kbd "F11") "fullscreen")
;; Set Window Title.
(define-key *root-map* (kbd "T") "title")
;; See Window Info.
(define-key *root-map* (kbd "i") "info")
;; See Window Properties.
(define-key *root-map* (kbd "I") "show-window-properties")
;; Mark window.
(define-key *root-map* (kbd ".") "mark")
;; Un-Mak window.
(define-key *root-map* (kbd ",") "clear-window-marks")
;; Pull marked windows.
(define-key *root-map* (kbd ">") "pull-marked")
;; List all groups as well as their windows.
(define-key *root-map* (kbd "G") "vgroups")
;; }}}  </utility commands>
;; {{{  <key maps>
(define-key *root-map* (kbd "g") '*GROUPS-MAP*)
(define-key *root-map* (kbd "x") '*EXCHANGE-WINDOW-MAP*)
(define-key *root-map* (kbd "h") '*HELP-MAP*)
;; }}}  </key maps>
;; }}} </root map>

;; {{{ <groups map>
;; {{{  <group management>
;; List groups.
(define-key *groups-map* (kbd "g") "groups")
;; New group.
(define-key *groups-map* (kbd "c") "gnew")
;; Move current window to specified group.
(define-key *groups-map* (kbd "m") "gmove")
;; Move marked windows to specified group.
(define-key *groups-map* (kbd "m") "gmove-marked")
;; Kill current group, moving all housed windows to the next group.
(define-key *groups-map* (kbd "k") "gkill")
;; Rename group.
(define-key *groups-map* (kbd "r") "grename")
;; }}}  </group management>
;; {{{  <group navigation>
;; List groups.
(define-key *groups-map* (kbd "\"") "grouplist")
;; Next group.
(define-key *groups-map* (kbd "n") "gnext")
;; Previous group.
(define-key *groups-map* (kbd "p") "gprevious")
;; Move focus and current window to next group.
(define-key *groups-map* (kbd "N") "gnext-with-window")
;; Move focus and current window to previous group.
(define-key *groups-map* (kbd "P") "gprevious-with-window")
;; Move to last active group.
(define-key *groups-map* (kbd "o") "gother")
;; }}}  </group navigation>
;; {{{  <jump to group by num>
;; Jump to group by number using groups map.
(define-key *groups-map* (kbd "1") "gselect 1")
(define-key *groups-map* (kbd "2") "gselect 2")
(define-key *groups-map* (kbd "3") "gselect 3")
(define-key *groups-map* (kbd "4") "gselect 4")
(define-key *groups-map* (kbd "5") "gselect 5")
(define-key *groups-map* (kbd "6") "gselect 6")
(define-key *groups-map* (kbd "7") "gselect 7")
(define-key *groups-map* (kbd "8") "gselect 8")
(define-key *groups-map* (kbd "9") "gselect 9")
(define-key *groups-map* (kbd "0") "gselect 0")
;; }}}  </jump to group by num>
;; }}} </groups map>

;; {{{ <exchange window map>
(define-key *exchange-window-map* (kbd "h") "exchange-direction left")
(define-key *exchange-window-map* (kbd "j") "exchange-direction down")
(define-key *exchange-window-map* (kbd "k") "exchange-direction up")
(define-key *exchange-window-map* (kbd "l") "exchange-direction right")
;; }}} </exchange window map>

;; {{{ <help map>
(define-key *help-map* (kbd "v") "describe-variable")
(define-key *help-map* (kbd "f") "describe-function")
(define-key *help-map* (kbd "k") "describe-key")
(define-key *help-map* (kbd "c") "describe-command")
(define-key *help-map* (kbd "w") "where-is")
;; }}} </help map>

