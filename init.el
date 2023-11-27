;; Don't show splash screen
(setq inhibit-startup-message t)
(global-display-line-numbers-mode t)
(load-theme 'wombat t)
(hl-line-mode 1)
(menu-bar-mode -1)
(setq mac-option-modifier 'meta)
(tooltip-mode -1)
(setq visible-bell t)

(require 'package)
(setq package-user-dir "~/tmp/elpa/")
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; font and font size
(add-to-list 'default-frame-alist
             '(font . "DejaVu Sans Mono-16"))

(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
(global-set-key (kbd "C-\"")        'mc/skip-to-next-like-this)
(global-set-key (kbd "C-:")         'mc/skip-to-previous-like-this)

(require 'move-text)
(global-set-key (kbd "M-p") 'move-text-up)
(global-set-key (kbd "M-n") 'move-text-down)

;;; slime
(setq inferior-lisp-program (executable-find "sbcl"))

;;; keycast
(load-file "~/keycast/keycast.el")
;;(package-install 'keycast)
(keycast-mode)
;; (keycast-log-mode)
(setq keycast-log-format "%-18K%C%R\n"
      keycast-remove-tail-elements nil
      keycast-log-frame-alist '((inhibit-switch-frame . t)
                                (pop-up-frame-parameters . ((font . "DejaVu Sans Mono-12")
                                                            (minibuffer . nil)))))
(push '(self-insert-command nil nil) keycast-substitute-alist)

(setq package-selected-packages '(lsp-mode yasnippet lsp-treemacs helm-lsp
    projectile hydra flycheck company avy which-key helm-xref dap-mode))

(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))

;; sample `helm' configuration use https://github.com/emacs-helm/helm/ for details
(helm-mode)
(require 'helm-xref)
(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)

(which-key-mode)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      lsp-idle-delay 0.1)  ;; clangd is fast

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))

(package-install 'eglot)

(package-install 'company)
(global-company-mode)

(setq eldoc-echo-area-use-multiline-p nil)

(require 'eglot)
(define-key eglot-mode-map (kbd "C-c <tab>") #'company-complete) ; initiate the completion manually
(define-key eglot-mode-map (kbd "C-c e f n") #'flymake-goto-next-error)
(define-key eglot-mode-map (kbd "C-c e f p") #'flymake-goto-prev-error)
(define-key eglot-mode-map (kbd "C-c e r") #'eglot-rename)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(zzz-to-char slime move-text multiple-cursors eglot lsp-mode yasnippet lsp-treemacs helm-lsp projectile hydra flycheck company avy which-key helm-xref dap-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
