;; Minor mode for shpec specification
;; Building draft

(defvar shpec-keywords
  `( (,(regexp-opt '( "describe" "it" "end") ; keywords
		   'words) . 'font-lock-function-name-face)
     ("assert" . 'font-lock-type-face) ; improve with arg
     (,(regexp-opt '("stub_command" "unstub_command")
		   'words) . 'font-lock-function-name-face)
     ;;matchers:
     (,(regexp-opt '("equal" "unequal" "gt" "lt" "match" "no_match"
		     "present" "blank" "file_present" "file_absent" "symlink" "test")
		   'words) . 'font-lock-builtin-face)
     )
  "Keyword for shpec specification.")

(define-derived-mode shpec-mode sh-mode "Shepc"
  "A mode for shpec specification"
  (font-lock-add-keywords nil shpec-keywords))

;; §TODO: hook

;; §TODO: make it extend sh-mode
;; hook to run test
(provide 'shpec-mode)
