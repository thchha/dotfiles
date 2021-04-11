;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  LSP-CONFIG  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(get-package 'lsp-mode)
(get-package 'lsp-ui)
(get-package 'company)
;(get-package 'company-quickhelp) does F1 the same? 
;(get-package 'company-lsp)
(get-package 'lsp-latex)

(add-hook 'c-or-c++-mode-hook #'lsp-deferred)
(add-hook 'lua-mode-hook #'lsp-deferred)
(add-hook 'latex-mode-hook #'lsp-deferred)
(add-hook 'tex-mode-hook #'lsp-deferred)
(add-hook 'bibtex-mode-hook #'lsp-deferred)

(setq lsp-ui-sideline-enable t)
(setq lsp-ui-doc-enable t)
(setq lsp-ui-peek-enable t)
(setq lsp-ui-peek-always-show t)

(setq company-selection-wrap-around t)

(define-key evil-normal-state-map (kbd "C-n") nil)
(define-key evil-normal-state-map (kbd "C-p") nil)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)

(setq company-idle-delay 0.3)
(setq company-minimum-prefix-length 0)

(global-company-mode t)

(push 'company-lsp company-backends)

(setq company-lsp-cache-candidates 'auto)
(setq company-lsp-async t)
(setq company-lsp-enable-snippet nil)
(setq company-lsp-enable-recompletion t)

;; LATEX

(setq lsp-clients-texlab-executable
      "/home/tomes/programs/texlab/target/release/texlab")

(setq lsp-latex-build-executable "latexmk")
;; check for output dir?
(setq lsp-latex-build-args '("-pdf" "-interaction=nonstopmode" "-outdir=./out" "-synctex=1" "-pvc" "-f" "%f"))
(setq lsp-latex-build-output-directory "./out")

(setq lsp-latex-forward-search-executable "okular")
(setq lsp-latex-forward-search-args '("--unique" "file:%p#src:%l%f"))

;;;;;;;; LUA
(setq lsp-clients-lua-language-server-install-dir "~/programs/lua-language-server/")
(setq lsp-clients-lua-language-server-bin "~/programs/lua-language-server/bin/Linux/lua-language-server")
;(setq lsp-clients-lua-language-server-main-location "~/programs/lua-language-server/main.lua")

