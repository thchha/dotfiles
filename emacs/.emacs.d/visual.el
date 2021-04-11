(unless (eq 'maximized (frame-parameter (selected-frame) 'fullscreen))
  (toggle-frame-maximized))

(add-to-list 'default-frame-alist
             '(font . "Monospace-12"))

(get-package 'sublimity)
(get-package 'ample-theme)

(require 'sublimity-scroll)
(setq sublimity-scroll-weight 5
      sublimity-scroll-drift-length 0)
(sublimity-mode 1)

(defun set-default-colors (dump)
	"called after the user enables a new theme"
	;(set-face-attribute 'mode-line nil :box nil)
	(setq default-mode-line-colors `(,(face-foreground 'mode-line) .
					 ,(face-background 'mode-line))))

(advice-add 'enable-theme :after #'set-default-colors)

(load-theme 'ample t t)
;(load-theme 'ayu-grey)
(enable-theme 'ample)

(setq tab-bar-border nil
      tab-bar-new-button nil
      tab-bar-close-button nil
      tab-bar-format '(tab-bar-format-history tab-bar-format-tabs)
      tab-bar-tab-hints t)

;(set-face-attribute 'tab-bar-tab :box nil)
 ;'(tab-bar-tab ((t nil)))

(set-face-foreground 'tab-bar (cdr default-mode-line-colors))
(set-face-background 'tab-bar (car default-mode-line-colors))
(set-face-foreground 'tab-bar (cdr default-mode-line-colors))
(set-face-background 'tab-bar-tab-inactive (cdr default-mode-line-colors))
(set-face-foreground 'tab-bar-tab-inactive (car default-mode-line-colors))


(setq scroll-margin 0
      scroll-conservatively 9999
      scroll-step 1)

(defun change-mode-line-color ()
  (let ((color (cond ((minibufferp) `(,(cdr default-mode-line-colors) . ,(car default-mode-line-colors)))
										 ((evil-normal-state-p) default-mode-line-colors)
                     ((evil-insert-state-p) '("#cd5542" . "#ffffff"))
                     ((evil-visual-state-p) '("#5180b3" . "#000000"))
                     ((evil-emacs-state-p) '("#bb55c3" . "#ffffff")))))
    (set-face-background 'mode-line (car color))
    (set-face-foreground 'mode-line (cdr color))))

(add-hook 'evil-normal-state-entry-hook #'change-mode-line-color)
(add-hook 'evil-visual-state-entry-hook #'change-mode-line-color)
(add-hook 'evil-insert-state-entry-hook #'change-mode-line-color)
(add-hook 'evil-emacs-state-entry-hook #'change-mode-line-color)
(add-hook 'minibuffer-setup-hook #'change-mode-line-color)
;(add-hook 'minibuffer-exit-hook #'(lambda () (interactive) (evil-normal-state) (change-mode-line-color)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; must have - transform cursor in terminal
(defun block-cursor ()
  (send-string-to-terminal (concat "\e[" "2" " q")))
(defun bar-cursor ()
  (send-string-to-terminal (concat "\e[" "6" " q")))
(if (not (display-graphic-p))
    (progn
      (add-hook 'evil-normal-state-entry-hook #'block-cursor)
      (add-hook 'evil-insert-state-entry-hook #'bar-cursor)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defun highlight-selected-window ()
  "Highlight selected window with a different background color."
  (walk-windows (lambda (w)
                  (unless (eq w (selected-window))
                    (with-current-buffer (window-buffer w)
                      (buffer-face-set '(:background "#202020"))))))
  (buffer-face-set 'default))
(add-hook 'buffer-list-update-hook 'highlight-selected-window)
