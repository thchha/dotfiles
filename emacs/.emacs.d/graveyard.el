;; Things which are not loaded, but having the snippets available could be handy.


;; instead of using vertico, marginalia and orderless, one could use ivy and ivy-rich.
;; unfortunately, ivy-rich is not working properly
;; also, the buffer menu and the file-picker are inconvenient.

; Bufferlist with ivy:
(evil-define-key 'normal global-map (kbd "SPC SPC") 'ivy-switch-buffer)

;(get-package 'ivy)
(setq ivy-wrap t)
(ivy-mode t)
(define-key ivy-minibuffer-map (kbd "<escape>") 'minibuffer-keyboard-quit)
(define-key ivy-minibuffer-map (kbd "M-\\") 'ur-toggle-ivy-completion-mode)
;
(defun ur-toggle-ivy-completion-mode ()
	"toggles the completion style and updates itself."
	(interactive)
	(setq ur--current-ivy-completion-style (ivy-rotate-preferred-builders))
	(setq ivy-pre-prompt-function
				(lambda ()
					(cond
					 ((equal ur--current-ivy-completion-style 'ivy--regex-fuzzy) "fuzzy-mode ")
					 ((equal ur--current-ivy-completion-style 'ivy--regex-plus) "regex-mode ")
					 ((equal ur--current-ivy-completion-style 'ivy--regex-ignore-order) "w/o-o-mode ")))))

(defun ur-switch-ivy-completion-from-minibuffer ()
	"Starts a execute-extended-command and adapts ivy to my preference.
   Cleans up afterwads."
	(defun ur--reset-ivy-completion-style ()
		"internal function, so that it can remove itself from a hook"
		(setq ivy-pre-prompt-function (lambda () "fuzzy-mode "))
		(setq ivy-re-builders-alist '((t . ivy--regex-fuzzy)))
		(remove-hook 'minibuffer-exit-hook 'ur--reset-ivy-completion-style))
	(setq ivy-pre-prompt-function (lambda () "regex-mode "))
	(setq ivy-re-builders-alist '((t . ivy--regex-plus)))
	(add-hook 'minibuffer-exit-hook 'ur--reset-ivy-completion-style)
	(execute-extended-command ""))


(define-key evil-ex-completion-map [tab]
	(lambda () (interactive)
		"change into M-x, if no ex was issued in advance."
		(if (null evil-ex-cmd)
				(progn
					(run-with-timer 0 nil (lambda () (execute-extended-command "")))
					(keyboard-escape-quit))
				(evil-ex-completion))))

(define-key evil-ex-completion-map [? ]
	(lambda () (interactive)
		"When starting an ex-command with a space, change into M-x and
		 make the ivy-completion style \"regex-plus\""
		(if (null evil-ex-cmd)
				(progn
					(run-with-timer 0 nil 'ur-switch-orderless-completion-from-minibuffer)
					(keyboard-escape-quit))
			(insert " "))))

;;; trigger completion without add-ins
(defun er-insert-and-tab-complete ()
	(interactive) (insert "-")
	(if (minibuffer-window-active-p (selected-window))
			(execute-kbd-macro (kbd "TAB"))))

(define-key minibuffer-local-map (kbd "-") 'er-insert-and-tab-complete)
(define-key minibuffer-local-completion-map (kbd "-") 'er-insert-and-tab-complete)
(define-key minibuffer-local-ns-map (kbd "-") 'er-insert-and-tab-complete)

;; way too slow:

;(defun ur-switch-orderless-completion-from-minibuffer ()
;	(setq vertico-count-format (cons "%-6s " "%s/%s regexp"))
;	(execute-extended-command ""))

(defvar ur--orderless-styles '(orderless-regexp
															 orderless-literal
															 ;orderless-without-literal
															 ;orderless-prefixes
															 orderless-initialism
															 ;orderless-strict-initialism
															 ;orderless-strict-leading-initialism
															 ;orderless-strict-full-initialism
															 orderless-flex))

(defun ur-toggle-orderless-style ()
	"toggles the completion style and updates itself."
	(interactive)
	(let* ((item (car ur--orderless-styles)))
    (setq ur--orderless-styles (append (cdr ur--orderless-styles) (list item)))
		(setq orderless-matching-styles (list item))
		(setq orderless-style-dispatchers nil)
		(vertico--consult-refresh)
		(setq vertico-count-format
					(cons "%-6s "
								(concat "%s/%s "
												(cond
												 ((equal item 'orderless-regexp) "regexp")
												 ((equal item 'orderless-literal) "literal")
												 ((equal item 'orderless-without-literal) "w/o-literal")
												 ((equal item 'orderless-prefixes) "prefixes")
												 ((equal item 'orderless-initialism) "initalism")
												 ((equal item 'orderless-strict-initialism) "strict")
												 ((equal item 'orderless-strict-leading-initialism) "leading")
												 ((equal item 'orderless-strict-full-initialism) "full-strict")
												 ((equal item 'orderless-flex) "flex")))))))

(define-key vertico-map (kbd "\\") 'ur-toggle-orderless-style)
