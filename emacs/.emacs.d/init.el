(if (string< emacs-version
	     "26.3")
    (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3"))

;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

(defvar *refreshed* nil
  "asserts that package-refresh is only run once per emacs session")

(defun get-package (pkg)
  "Installs and requires an package if it is absent."
  (progn
    (unless (package-installed-p pkg)
      (if (eq *refreshed* nil)
          (setq *refreshed* (progn
                              (package-refresh-contents)
                              t )))
      (package-install pkg))
    (eval-and-compile
      (require pkg))))

(load "~/.emacs.d/visual")
(load "~/.emacs.d/configuration")
(load "~/.emacs.d/lsp-configuration")
(load "~/.emacs.d/org-configuration")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;; EMACS CUSTOMIZATION ;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
	 '("c9ddf33b383e74dac7690255dd2c3dfa1961a8e8a1d20e401c6572febef61045" default))
 '(evil-undo-system 'undo-redo)
 '(package-selected-packages
	 '(evil-vimish-fold vimish-fold magit java-imports slime lua-mode git-gutter goto-chg pdf-tools ample-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(trailing-whitespace ((t (:background "brown" :weight bold)))))
