;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  GENERAL  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(get-package 'rainbow-mode)
(get-package 'magit)
;(get-package 'vimish-fold) no nested foling?!
(get-package 'impatient-mode)
(get-package 'android-mode)

(get-package 'vertico)
(get-package 'orderless)
(get-package 'marginalia)

(setq x-selection-timeout 5)

(fset 'yes-or-no-p 'y-or-n-p)

(electric-indent-mode 0)

(setq inhibit-splash-screen t)

(setq-default tab-width 2
							evil-shift-width 2)
(setq-default indent-tabs-mode 0)

(setq-default show-trailing-whitespace t)
(add-hook 'completion-list-mode-hook (lambda () (setq show-trailing-whitespace nil)))

;; places all backups/auto-save files to /tmp
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(save-place-mode 1)

(add-hook 'prog-mode-hook #'hs-minor-mode) ; enable folding
(add-hook 'prog-mode-hook #'hs-minor-mode) ; enable folding

(column-number-mode 1)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(global-display-line-numbers-mode t)
(show-paren-mode t)

(size-indication-mode 1)

(global-visual-line-mode t)

(setq help-window-select t)

(vertico-mode t)
(marginalia-mode t)

(setq marginalia-annotators
			'(marginalia-annotators-heavy ; files
				marginalia-annotators-heavy ; ext-cmd
				marginalia-annotators-light))

(setq orderless-component-separator " +\\|[-/]"
			orderless-matching-styles '(orderless-regexp))

(setq completion-styles '(substring substring flex orderless)
			completion-category-defaults nil
			completion-category-overrides '((file (styles . (partial-completion)))))

(define-key global-map (kbd "C-c") (lambda () (interactive) (abort-recursive-edit) (kbd "C-g")))

(defun hardened-escape ()
	"refocuses the minbuffer, if in use; else it will abort anything and put into normal mode"
	(interactive)
	(if (active-minibuffer-window)
			(progn
				(select-frame-set-input-focus (window-frame (active-minibuffer-window)))
				(select-window (active-minibuffer-window)))
		(progn
			(abort-recursive-edit)
			(keyboard-escape-quit)
			(evil-force-normal-state))))


(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)


(global-set-key [escape] 'hardened-escape)
(global-set-key (kbd "«") 'execute-extended-command)

(global-unset-key (kbd "C-x C-t"))
(global-unset-key (kbd "C-<down-mouse-1>"))
(global-unset-key (kbd "C-<down-mouse-2>"))
(global-unset-key (kbd "C-<down-mouse-3>"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  EVIL-CONFIG  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(get-package 'goto-chg)

(setq evil-want-C-d-scroll t)
(setq evil-want-C-u-scroll t)

(get-package 'evil)
(get-package 'evil-surround)
(add-to-list 'load-path "~/.emacs.d/evil-arglist")
(require 'evil-arglist)

(defun evil-ex-abort ()
	"Override the default behaviour, so that ex commands survive missclicks")

(global-evil-surround-mode 1)

(setq evil-respect-visual-line-mode t)

(evil-set-undo-system 'undo-redo)

(setq evil-want-C-i-jump 1)

(setq evil-auto-balance-windows nil)


(setq evil-normal-state-modes
      (append evil-emacs-state-modes
              evil-insert-state-modes
              evil-normal-state-modes
              evil-motion-state-modes))

(setq evil-vsplit-window-right 1)
(setq evil-split-window-below 1)

(setq evil-emacs-state-modes nil)
(setq evil-motion-state-modes nil)

(evil-mode t)
(define-key evil-normal-state-map [escape] nil)

(evil-ex-define-cmd "so" #'load-file)
(evil-ex-define-cmd "W" #'save-buffer)

(evil-ex-define-cmd "Config" (lambda () (interactive) (find-file "/home/tomes/.emacs.d/configuration.el")))

(evil-ex-define-cmd "Wiki" (lambda () (interactive) (find-file "/home/tomes/documents/wiki/index.md")))
(evil-ex-define-cmd "Todo" (lambda () (interactive) (find-file "/home/tomes/documents/todo/todo.md")))

;;;;;;;;;;;
;;; MAP ;;;
;;;;;;;;;;;

(defvar vim-leader-map (make-sparse-keymap))
(define-key evil-emacs-state-map (kbd "\\") vim-leader-map)
(define-key evil-normal-state-map (kbd "\\") vim-leader-map)
(define-key evil-visual-state-map (kbd "\\") vim-leader-map)
(define-key evil-insert-state-map (kbd "TAB") 'tab-to-tab-stop)

(evil-define-key 'insert global-map (kbd "RET") 'newline-and-indent)
(evil-define-key 'normal global-map (kbd "_") (lambda () (interactive) (dired-jump nil default-directory)))

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
		 enable matching with whitespaces"
		(if (null evil-ex-cmd)
				(progn
					(run-with-timer 0 nil (lambda () (execute-extended-command "")))
					(keyboard-escape-quit))
			(insert " "))))

(evil-define-key 'normal global-map (kbd "SPC SPC")
  (lambda () (interactive)
    (minibuffer-with-setup-hook
        '(lambda () (execute-kbd-macro (kbd "TAB")))
      (call-interactively (evil-ex "buffer ")))))

(define-key vertico-map (kbd "<escape>") 'keyboard-escape-quit)
(define-key vertico-map (kbd "C-p") 'vertico-previous)
(define-key vertico-map (kbd "C-n") 'vertico-next)
(define-key evil-ex-completion-map "\C-p" (lambda () (interactive) (switch-to-completions) (previous-completion)))
(define-key evil-ex-completion-map "\C-n" (lambda () (interactive) (switch-to-completions) (next-completion)))
(define-key completion-list-mode-map (kbd "<return>") #'choose-completion)

(evil-define-key 'normal xref--xref-buffer-mode-map (kbd "<return>") 'xref-goto-xref)

(evil-define-key 'normal global-map (kbd "gr") 'xref-find-references)

(evil-define-key 'insert global-map "-"
  (lambda () (interactive) (insert "-")
    (if (minibuffer-window-active-p (selected-window))
        (execute-kbd-macro (kbd "TAB")))))

(evil-define-key 'normal evil-window-map (kbd "q")
  (lambda () (interactive)
    (if (= (length (window-list)) 1)
        (kill-buffer)
      (evil-quit))))

(evil-define-key 'normal global-map (kbd "<f5>") 'delete-trailing-whitespace)

(evil-define-key 'visual global-map (kbd "<")
  (lambda () (interactive)
    (let ((sel (evil-visual-range)))
      (evil-shift-left (car sel) (cadr sel)))
    (funcall (evil-visual-restore))))

(evil-define-key 'visual global-map (kbd ">")
  (lambda () (interactive)
    (let ((sel (evil-visual-range)))
      (evil-shift-right (car sel) (cadr sel)))
    (funcall (evil-visual-restore))))

;;;;;;;;;;;;;
;;; DIRED ;;;
;;;;;;;;;;;;;

(defvar dired-vim-leader-remap (make-sparse-keymap))

(evil-define-key 'normal dired-mode-map (kbd "?") 'evil-search-backward)
(evil-define-key 'normal dired-mode-map (kbd "SPC") dired-vim-leader-remap)
(define-key dired-vim-leader-remap (kbd "?") 'dired-summary)

(evil-define-key 'normal global-map (kbd "-") (lambda () (interactive)
                                                (if (derived-mode-p 'dired-mode)
                                                    (dired-up-directory ())
                                                  (dired-jump ()))))

;; swapping the behaviour to be dirvish-like
(evil-define-key 'normal dired-mode-map (kbd "RET") (lambda () (interactive)
                                                      (dired-find-alternate-file)))
(evil-define-key 'normal dired-mode-map (kbd "v") (lambda () (interactive)
                                                    (dired-find-file)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  GIT-GUTTER  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(get-package 'git-gutter)
(setq git-gutter:update-interval 2)
(add-hook 'prog-mode-hook #'git-gutter-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  LANGUAGES  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; THESAURUS
(load "~/.emacs.d/synonyms")
;; first escape all commas in the file
;; then transform the semicolons to commas.
(setq synonyms-file "~/.emacs.d/openthesaurus.txt")
(setq synonyms-cache-file  "~/.emacs.d/.cache/synonyms-cache")
(require 'synonyms)

(defun get-synonym-word ()
	(interactive)
	(synonyms-lookup (thing-at-point 'word) nil nil))
(evil-define-key 'insert global-map (kbd "C-x C-t") 'get-synonym-word)

;; latex
(get-package 'pdf-tools)
(pdf-loader-install)


;;; lua
(get-package 'lua-mode)

(setq lua-indent-level 2)
(setq lua-indent-string-contents t)
(setq lua-prefix-key nil)

;:mode "\\.lua$"
;:interpreter "lua"
;(add-hook 'lua-mode #'(lambda ()
;(setq-local company-backends '(
;(company-lsp company-lua company-keywords)
;company-capf company-dabbrev-code company-files ))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  SLIME/GEISER  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(get-package 'slime)
(slime-setup '(slime-repl))
