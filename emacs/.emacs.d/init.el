(if (string< emacs-version
	     "26.3")
    (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3"))

(setq gc-cons-threshold 1000000)

(if (not (file-exists-p "~/.emacs.d/.cache"))
    (make-directory "~/.emacs.d/.cache"))
(setq savehist-file "~/.emacs.d/.cache/history"
			savehist-additional-variables '(kill-ring search-ring regexp-search-ring))
(savehist-mode 1)

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

(add-to-list 'load-path "~/.emacs.d/icicles/")

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
	 '("d3d9bc3c7a7c87059cededb67caad7388a3db75274391a8d929ee2d9fd2a1fa3" "2a88d286fde1e972bbb27c41884d0d97f2783e0f81925a7ed153aedf224eb427" "483ca5d0481f005b5e6233763c221ef41f9cc879570497142327583de95f9fc9" "d5a878172795c45441efcd84b20a14f553e7e96366a163f742b95d65a3f55d71" "7a994c16aa550678846e82edc8c9d6a7d39cc6564baaaacc305a3fdc0bd8725f" "e3c64e88fec56f86b49dcdc5a831e96782baf14b09397d4057156b17062a8848" "ca70827910547eb99368db50ac94556bbd194b7e8311cfbdbdcad8da65e803be" "79278310dd6cacf2d2f491063c4ab8b129fee2a498e4c25912ddaa6c3c5b621e" "0685ffa6c9f1324721659a9cd5a8931f4bb64efae9ce43a3dba3801e9412b4d8" "e6ff132edb1bfa0645e2ba032c44ce94a3bd3c15e3929cdf6c049802cf059a2a" "990e24b406787568c592db2b853aa65ecc2dcd08146c0d22293259d400174e37" "7b3d184d2955990e4df1162aeff6bfb4e1c3e822368f0359e15e2974235d9fa8" "54cf3f8314ce89c4d7e20ae52f7ff0739efb458f4326a2ca075bf34bc0b4f499" "7546a14373f1f2da6896830e7a73674ef274b3da313f8a2c4a79842e8a93953e" "2cdc13ef8c76a22daa0f46370011f54e79bae00d5736340a5ddfe656a767fddf" "fd22c8c803f2dac71db953b93df6560b6b058cb931ac12f688def67f08c10640" "3c2f28c6ba2ad7373ea4c43f28fcf2eed14818ec9f0659b1c97d4e89c99e091e" "fce3524887a0994f8b9b047aef9cc4cc017c5a93a5fb1f84d300391fba313743" "8f5a7a9a3c510ef9cbb88e600c0b4c53cdcdb502cfe3eb50040b7e13c6f4e78e" default))
 '(package-selected-packages
	 '(sublimity ayu-theme rainbow-mode synonyms evil-vimish-fold vimish-fold magit java-imports)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(trailing-whitespace ((t (:background "brown" :weight bold)))))
