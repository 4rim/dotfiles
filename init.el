;; Don't show splash screen
(global-display-line-numbers-mode t)
(load-theme 'wombat t)
(hl-line-mode 1)
(menu-bar-mode -1)
(setq mac-option-modifier 'meta)
(tooltip-mode -1)
(xterm-mouse-mode 1)
(setq visible-bell t)
(setq-default tab-width 4)
(setq inhibit-startup-message 't)
(setq initial-major-mode 'fundamental-mode)
(setq initial-scratch-message 'nil)
(setq make-backup-files nil)

(require 'package)
;; (setq package-user-dir "~/tmp/elpa/")
;; (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(require 'yasnippet)

(setq yas/triggers-in-field nil)
(setq yas-snippet-dirs '("~/.emacs.d/snippets"))

(yas-global-mode 1)

(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
(global-set-key (kbd "C-\"")        'mc/skip-to-next-like-this)
(global-set-key (kbd "C-:")         'mc/skip-to-previous-like-this)

;;; slime
(setq inferior-lisp-program (executable-find "sbcl"))

(setq eldoc-echo-area-use-multiline-p nil)

;;; eglot
(require 'eglot)
(define-key eglot-mode-map (kbd "C-c <tab>") #'company-complete) ; initiate the completion manually
(define-key eglot-mode-map (kbd "C-c e f n") #'flymake-goto-next-error)
(define-key eglot-mode-map (kbd "C-c e f p") #'flymake-goto-prev-error)
(define-key eglot-mode-map (kbd "C-c e r") #'eglot-rename)

;;; marks 80th column width
(setf fill-column 80)

(require 'tuareg)
(autoload 'tuareg-mode "tuareg" "Major mode for editing OCaml code" t) (add-to-list 'auto-mode-alist '("\\.ml[ily]?$" . tuareg-mode))

(add-hook 'latex-mode-hook #'auto-fill-mode)
(add-hook 'coq-mode-hook #'company-coq-mode)
(add-hook 'tuareg-mode-hook (lambda () (setq-local comment-start ";; ")))
;; (add-hook 'tuareg-mode-hook 'merlin-mode)
;; (add-hook 'caml-mode-hook 'merlin-mode) (add-hook 'lisp-mode-hook 'merlin-mode)

;; (setq merlin-error-after-save nil) (setq merlin-command 'opam)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(markdown-mode merlin ## tuareg company-coq zzz-to-char proof-general gpr-yasnippets yasnippet-lean slime move-text multiple-cursors eglot lsp-mode yasnippet lsp-treemacs helm-lsp projectile hydra flycheck company avy which-key helm-xref dap-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
;; (require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line
