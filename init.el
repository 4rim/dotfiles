;;; init.el  --- -*- lexical-binding: t -*-

(setq gc-cons-threshold (* 1024 1024 20))

(global-display-line-numbers-mode t)
(load-theme 'leuven-dark t)
(xterm-mouse-mode 1)
(display-fill-column-indicator-mode t)
(global-auto-revert-mode t)

(when (>= emacs-major-version 29)
  (pixel-scroll-precision-mode 1))

(setq visible-bell t
      make-backup-files nil
      inhibit-startup-message t
      inhibit-splash-screen t
      initial-major-mode 'fundamental-mode
      split-height-threshold nil
      split-width-threshold 0
      sentence-end-double-space nil
      organic-green-version 2
      frame-inhibit-implied-resize 't)

(defun zoom-in ()
  (interactive)
  (let ((x (+ (face-attribute 'default :height)
              10)))
    (set-face-attribute 'default nil :height x)))

(defun zoom-out ()
  (interactive)
  (let ((x (- (face-attribute 'default :height)
              10)))
    (set-face-attribute 'default nil :height x)))

(define-key global-map (kbd "C-1") 'zoom-in)
(define-key global-map (kbd "C-0") 'zoom-out)

(setq mode-line-format '((buffer-file-name "%f" ("%b"))
                         mode-line-front-space
                         "%e"
                         mode-line-modified
                         mode-line-position
                         (vc-mode vc-mode)
                         mode-line-modes
                         mode-line-misc-info
                         mode-line-end-spaces))

(setq-default tab-width 4
              fill-column 80
              indent-tabs-mode nil
              ; auto-fill-function 'do-auto-fill
              sentence-end-double-space nil
              indent-line-function 'insert-tab)

(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)
(set-frame-font "Iosevka 13" nil t)

(require 'package)
(add-to-list 'package-archives
             '(("MELPA" . "https://melpa.org/packages/")
               ("GNU" . "https://elpa.gnu.org/packages/")
             ))

(add-to-list 'load-path "~/dotfiles/better-defaults")
(require 'better-defaults)

(defvar packages '(comment-tags
                   company-lean
                   company
                   counsel
                   cdlatex
                   eglot
                   flycheck
                   org-fragtog
                   go-mode
                   haskell-mode
                   ido
                   ivy
                   lean-mode
                   lsp-haskell
                   lsp-mode
                   organic-green-theme
                   multiple-cursors
                   org-super-agenda
                   swiper
                   visual-fill-column
                   vterm
                   which-key
                   windmove
                   yasnippet
                   proof-general
                   centered-cursor-mode))

(dolist (p packages)
  (unless (package-installed-p p)
    (package-refresh-contents)
    (package-install p))
  (add-to-list 'package-selected-packages p))

;; Open .v files with Proof-General's coq-mode
(require 'proof-site "~/.emacs.d/lisp/PG/generic/proof-site")

;; Load company-coq when opening Coq files
(add-hook 'coq-mode-hook #'company-coq-mode)

(setq load-path (cons "~/.emacs/lean4-mode" load-path))

(setq lean4-mode-required-packages '(dash flycheck lsp-mode magit-section))

;; (require 'package)
;; (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;; (package-initialize)
;; (let ((need-to-refresh t))
;;  (dolist (p lean4-mode-required-packages)
;;    (when (not (package-installed-p p))
;;      (when need-to-refresh
;;        (package-refresh-contents)
;;        (setq need-to-refresh nil))
;;      (package-install p))))

;; (require 'lean4-mode)

(fset 'yes-or-no-p 'y-or-n-p)

(setq org-startup-indented t
      org-ellipsis " . "
      org-pretty-entities t
      org-hide-emphasis-markers t
      org-fontify-whole-heading-line t)

(dolist (mode
         '(tool-bar-mode
           scroll-bar-mode
           blink-cursor-mode))
  (funcall mode 0))

(dolist (mode
         '(delete-selection-mode
         column-number-mode
         recentf-mode
         show-paren-mode))
  (funcall mode 1))

(use-package diff-hl
  :config
  (global-diff-hl-mode 1))

(add-to-list 'default-frame-alist '(undecorated . t))
(add-to-list 'default-frame-alist '(internal-border-width . 12))

(ivy-mode)
(counsel-mode)
(ido-mode)
(centered-cursor-mode)

;; Must do this so the agenda knows where to look for my files
(setq org-agenda-files '("~/org"))

;; When a TODO is set to a done state, record a timestamp
(setq org-log-done 'time)

;; Follow the links
(setq org-return-follows-link  t)

;; Associate all org files with org mode
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

;; Make the indentation look nicer
(add-hook 'org-mode-hook 'org-indent-mode)

;; Shortcuts for storing links, viewing the agenda, and starting a capture
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)

;; Hide the markers so you just see bold text as BOLD-TEXT and not *BOLD-TEXT*
(setq org-hide-emphasis-markers t)

;; Wrap the lines in org mode so that things are easier to read
(add-hook 'org-mode-hook 'visual-line-mode)

(setq org-capture-templates
      '(("j" "Notes" entry (file+olp+datetree "~/org/notes.org")
         "* %?" :empty-lines 1)
        ("p" "Russian words, sentences" entry (file+datetree "~/org/russianvocab.org")
         "* %?")
        ("e" "Diary" entry (file+olp+datetree "~/org/diary.org")
         "* %?\nEntered on %T")
        ("t" "TODO" checkbox (file+olp+datetree "~/org/todo.org")
         "* %?")
        ))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((ledger . t))
 )

(setq ivy-display-style 'fancy)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(setq ivy-wrap t)

(defun counsel-ag-thing-at-point ()
  (interactive)
  (ivy-with-thing-at-point 'counsel-ag))

(global-set-key (kbd "<C-tab>") 'other-window)
(global-set-key (kbd "C-a") 'move-beginning-of-line)
(global-set-key (kbd "C-e") 'move-end-of-line)
(global-set-key (kbd "C-f") 'scroll-down)
(global-set-key (kbd "C-s") 'swiper-isearch)
(global-set-key (kbd "C-v") 'scroll-up)
(global-set-key (kbd "C-i") 'kill-region)
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "C-j") 'next-line)
(global-set-key (kbd "C-y") 'kill-ring-save)
(global-set-key (kbd "C-p") 'yank)
(global-set-key (kbd "C-d") 'kill-whole-line)
(global-set-key (kbd "C-k") 'previous-line)
(global-set-key (kbd "C-h") 'backward-char)
(global-set-key (kbd "C-l") 'forward-char)
(global-set-key (kbd "C-w") 'forward-word)
(global-set-key (kbd "C-b") 'backward-word)
(global-set-key (kbd "M-j") 'forward-paragraph)
(global-set-key (kbd "M-k") 'backward-paragraph)

(global-set-key (kbd "C-z") 'recenter-top-bottom)

(global-set-key (kbd "C-x h")  'windmove-left)
(global-set-key (kbd "C-x l") 'windmove-right)
(global-set-key (kbd "C-x k")    'windmove-up)
(global-set-key (kbd "C-x j")  'windmove-down)

(defvar my-keys-minor-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "<C-tab>") 'other-window)
    (define-key map (kbd "C-a") 'move-beginning-of-line)
    (define-key map (kbd "C-e") 'move-end-of-line)
    (define-key map (kbd "C-f") 'scroll-down)
    (define-key map (kbd "C-s") 'swiper-isearch)
    (define-key map (kbd "C-v") 'scroll-up)
    (define-key map (kbd "C-i") 'kill-region)
    (define-key map (kbd "M-g") 'goto-line)
    (define-key map (kbd "C-j") 'next-line)
    (define-key map (kbd "C-y") 'kill-ring-save)
    (define-key map (kbd "C-p") 'yank)
    (define-key map (kbd "C-d") 'kill-whole-line)
    (define-key map (kbd "C-k") 'previous-line)
    (define-key map (kbd "C-h") 'backward-char)
    (define-key map (kbd "C-l") 'forward-char)
    (define-key map (kbd "C-w") 'forward-word)
    (define-key map (kbd "C-b") 'backward-word)
    (define-key map (kbd "M-j") 'forward-paragraph)
    (define-key map (kbd "M-k") 'backward-paragraph)
    map)
  "my-keys-minor-mode keymap.")

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  :init-value t
  :lighter " my-keys")

(my-keys-minor-mode 1)

(setq next-line-add-newlines t)

(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

(global-set-key (kbd "C-c e") 'eshell)
(global-set-key (kbd "C-c x") 'async-term)

(setq yas/triggers-in-field nil)

(setq yas-snippet-dirs '("~/.emacs.d/snippets/"
                         "~/.emacs.d/elpa/yasnippet-snippets-20240603.757/snippets"))

(yas-global-mode 1)

(define-key yas-minor-mode-map (kbd "<tab>") yas-maybe-expand)

(global-set-key (kbd "C-S-e C-S-e") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
(global-set-key (kbd "C-\"")        'mc/skip-to-next-like-this)
(global-set-key (kbd "C-:")         'mc/skip-to-previous-like-this)

;;; eglot
;; (define-key eglot-mode-map (kbd "C-c <tab>") #'company-complete) ; initiate the completion manually
;; (define-key eglot-mode-map (kbd "C-c e f n") #'flymake-goto-next-error)
;; (define-key eglot-mode-map (kbd "C-c e f p") #'flymake-goto-prev-error)
;; (define-key eglot-mode-map (kbd "C-c e r") #'eglot-rename)
(use-package eglot
  :config
  (add-to-list 'eglot-server-programs
               '(svelte-mode . ("svelteserver" "--stdio:"))))

;;; haskell-mode
(use-package haskell-mode
  :defer t
  :hook ((haskell-mode . interactive-haskell-mode)
         (haskell-mode . turn-on-haskell-doc-mode)
         (haskell-mode . turn-on-haskell-indentation)))
(add-to-list 'completion-ignored-extensions ".hi")

(use-package which-key
  :config
  (which-key-mode 1))

(global-set-key (kbd "S-SPC") #'company-complete)

;; You need to modify the following line
(setq load-path (cons "~/.local/lean4-mode" load-path))

(setq lean4-mode-required-packages '(dash flycheck lsp-mode magit-section))

(let ((need-to-refresh t))
  (dolist (p lean4-mode-required-packages)
    (when (not (package-installed-p p))
      (when need-to-refresh
        (package-refresh-contents)
        (setq need-to-refresh nil))
      (package-install p))))

(require 'lean4-mode)

(add-hook 'LaTeX-mode-hook 'cdlatex-mode)
(add-hook 'LaTeX-mode-hook 'prettify-symbols-mode)
(add-hook 'org-mode-hook #'olivetti-mode)
(add-hook 'org-mode-hook #'org-fragtog-mode)
(add-hook 'org-mode-hook #'visual-line-mode)
(add-hook 'coq-mode-hook #'company-coq-mode)
(add-hook 'racket-mode-hook #'paredit-mode)
(add-hook 'haskell-mode-hook #'lsp)
(add-hook 'haskell-literate-mode-hook #'lsp)
(add-hook 'go-mode-hook 'lsp-deferred)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-format-latex-options
   '(:foreground default :background default :scale 1.5 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
				 ("begin" "$1" "$" "$$" "\\(" "\\[")))
 '(package-selected-packages
   '(org-fragtog tao-theme racket-mode magit elscreen counsel swiper go-mode markdown-mode merlin ## tuareg company-coq zzz-to-char proof-general gpr-yasnippets yasnippet-lean slime move-text multiple-cursors eglot lsp-mode yasnippet lsp-treemacs helm-lsp projectile hydra flycheck company avy which-key helm-xref dap-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
;; (require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line
