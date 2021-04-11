;; force a file to org-mode:
; @0:   EMACS CONFIGURATION    -*- mode: org; -*-
(setq org-insert-mode-line-in-empty-file t)

(evil-define-key 'normal org-mode-map (kbd "g d") 'org-open-at-point)
(define-key vim-leader-map (kbd "=") 'org-table-align)
(define-key vim-leader-map (kbd "ocl") 'org-store-link)
(define-key vim-leader-map (kbd "oga") 'org-agenda)
(define-key vim-leader-map (kbd "occ") 'org-capture)

(setq org-link-frame-setup
      '((vm . vm-visit-folder)
        (vm-imap . vm-visit-imap-folder)
        (gnus . org-gnus-no-new-news)
        (file . find-file)
        (wl . wl)))

(defun capture-as-org-file ()
  (interactive)
  (let* ((wap (thing-at-point 'symbol))
         (name (read-string (concat "Filename (else: " wap "): "))))
    (expand-file-name (format "%s%s.org"
                              "~/Documents/wiki/org_mode/"
                              (if (string-empty-p name) wap name)))))

(defun tomahagq/template-from-word-at-point ()
  (concat "* Reference for: " (thing-at-point 'symbol) "\n\n\tOrigin: %a\n\tDescription:\n\t%?\n\n%U"))

(setq org-capture-templates
      '(("r" ; key
         "Reference" ; description
         entry ; type
         (file capture-as-org-file) ; target
         (function tomahagq/template-from-word-at-point)) ; rest properties
        ("t" "Todo" entry (file+headline "~/org/gtd.org" "Tasks") "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree "~/org/journal.org") "* %?\nEntered on %U\n  %i\n  %a")))
