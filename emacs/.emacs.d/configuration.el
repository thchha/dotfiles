;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  GENERAL  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;

;; refer to lsp-configuration.el
(get-package 'lsp-mode)
(get-package 'lsp-ui)
(get-package 'company)
(get-package 'company-lsp)
(get-package 'lsp-latex)

;; refer to visual.el
(get-package 'ample-theme)

(get-package 'magit)
;(get-package 'vimish-fold) no nested foling?!
(get-package 'impatient-mode)
(get-package 'android-mode)

;; prohibit autochanging the working directory
(add-hook 'find-file-hook
          (lambda ()
            (setq default-directory command-line-default-directory)))

(setq gc-cons-threshold 1000000)
(setq x-selection-timeout 5)

(add-to-list 'default-frame-alist
             '(font . "Monospace-12"))

(fset 'yes-or-no-p 'y-or-n-p)

(electric-indent-mode 0)

(setq inhibit-splash-screen t)

(setq-default tab-width 2)
(setq-default indent-tabs-mode 0)

(setq-default show-trailing-whitespace t)

;; places all backups/auto-save files to /tmp
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(save-place-mode 1)

(add-hook 'prog-mode-hook #'hs-minor-mode) ; enable folding

(column-number-mode 1)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(global-display-line-numbers-mode t)
(show-paren-mode t)

(display-time-mode 1)
(size-indication-mode 1)

(visual-line-mode t)

(setq help-window-select nil)

(define-key global-map (kbd "C-c") (lambda () (interactive) (abort-recursive-edit) (kbd "C-g")))
;(define-key global-map (kbd "TAB") nil)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "«") 'execute-extended-command)

(global-unset-key (kbd "C-<down-mouse-1>"))
(global-unset-key (kbd "C-<down-mouse-2>"))
(global-unset-key (kbd "C-<down-mouse-3>"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  EVIL-CONFIG  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(get-package 'goto-chg)


(get-package 'evil)
(get-package 'evil-surround)

(global-evil-surround-mode 1)

(setq evil-want-C-d-scroll t)
(setq evil-want-C-u-scroll t)
(setq evil-respect-visual-line-mode t)

;(setq evil-undo-system 'undo-redo)

(setq evil-want-C-i-jump 1)

(setq evil-auto-balance-windows nil)


(setq evil-normal-state-modes
      (append evil-emacs-state-modes
              evil-insert-state-modes
              evil-normal-state-modes
              evil-motion-state-modes))

(setq evil-vsplit-window-right 1)

(setq evil-emacs-state-modes nil)
(setq evil-motion-state-modes nil)

(evil-mode t)

(evil-ex-define-cmd "so" #'load-file)
(evil-ex-define-cmd "W" #'save-buffer)

(evil-ex-define-cmd "Config" (lambda () (interactive) (find-file "/home/tomes/.emacs.d/configuration.el")))

(evil-ex-define-cmd "Wiki" (lambda () (interactive) (find-file "/home/tomes/documents/wiki/index.md")))
(evil-ex-define-cmd "Todo" (lambda () (interactive) (find-file "/home/tomes/documents/todo/todo.md")))

;;;;;;;;;;;
;;; MAP ;;;
;;;;;;;;;;;

(defvar vim-leader-map (make-sparse-keymap))
(define-key evil-normal-state-map (kbd "\\") vim-leader-map)
(define-key evil-visual-state-map (kbd "\\") vim-leader-map)
(define-key evil-insert-state-map (kbd "TAB") 'tab-to-tab-stop)

(evil-define-key 'normal global-map (kbd "\\ RET") 'evil-buffer)
(evil-define-key 'normal global-map (kbd "_") (lambda () (interactive) (dired-jump nil default-directory)))

;; Bufferlist
(evil-define-key 'normal global-map (kbd "SPC SPC")
  (lambda () (interactive)
    (minibuffer-with-setup-hook
        '(lambda () (execute-kbd-macro (kbd "TAB")))
      (call-interactively (evil-ex "buffer ")))))

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
