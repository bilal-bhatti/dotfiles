;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;;(eval-when-compile
;;  (require 'use-package))

;; set custom file for customizations
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; set shell for emacs to bash
(setq explicit-shell-file-name "/bin/bash")
(setq shell-file-name "bash")

;; If in gui, or else
(if (display-graphic-p)
    (progn
      ;; disable scroll bars
      (scroll-bar-mode -1)
      (tool-bar-mode -1)

      ;; set default font
      (let ((fontset "fontset-default"))
	(set-fontset-font fontset 'latin '("Source Code Pro"))
	(set-face-attribute 'default nil
			    :font fontset
			    :weight 'semi-bold
			    :height 120))
      (defun get-default-height ()
	(/ (- (display-pixel-height) 75)
	   (frame-char-height)))
      (add-to-list 'default-frame-alist '(width . 125))
      (add-to-list 'default-frame-alist (cons 'height (get-default-height)))
      )
  )

;; set appearance settings
(setq inhibit-startup-screen t)
(x-focus-frame nil)
(setq visible-bell 1)
(global-linum-mode 1)
(setq linum-format "%4d \u2502")
(setq c-basic-offset 4) ; indents 4 chars
(setq tab-width 4)          ; and 4 char wide for TAB
(setq indent-tabs-mode nil) ; And force use of spaces

;; start: load solarized theme
;; from the main solarized repo
;;(set-frame-parameter nil 'background-mode 'dark)
;;(set-terminal-parameter nil 'background-mode 'dark)
;;(setq frame-background-mode 'dark)
;;(mapc 'frame-set-background-mode (frame-list))
;;((add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized")
;;(load-theme 'solarized t)
;; end: load solarized theme

;; load solarized theme from elpa
(use-package solarized-theme
  :ensure t
  :defer t
  :init
  (load-theme 'solarized-dark t))

;; setup parentheses highlighging
(show-paren-mode 1)
(setq show-paren-style 'parenthesis)

;; init exec-path from shell path
(use-package exec-path-from-shell
  :ensure t)
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; setup multiple-cursors
;;(use-package multiple-cursors :ensure t)
;;(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
;;(global-set-key (kbd "C->") 'mc/mark-next-like-this)
;;(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
;;(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; enable evil leader, before evil mode
(use-package evil-leader
  :ensure t
  :init
  (global-evil-leader-mode)
  :config
  (evil-leader/set-leader ",")
  (evil-leader/set-key
    "e" 'find-file
    "b" 'switch-to-buffer
    "k" 'kill-buffer)
  )

;; configure evil mode
(use-package evil
  :ensure t
  :init
  (evil-mode t)
  :config
  (progn
    (define-key evil-normal-state-map [escape] 'keyboard-quit)
    (define-key evil-visual-state-map [escape] 'keyboard-quit)
    (define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
    (define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
    (define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
    (define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
    (define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

    ;; evil: bring back basic emacs command
    (define-key evil-normal-state-map "\C-y" 'yank)
    (define-key evil-insert-state-map "\C-y" 'yank)
    (define-key evil-visual-state-map "\C-y" 'yank)
    ;;(define-key evil-insert-state-map "\C-e" 'end-of-line)
    ;;(define-key evil-normal-state-map "\C-w" 'evil-delete)
    ;;(define-key evil-insert-state-map "\C-w" 'evil-delete)
    ;;(define-key evil-insert-state-map "\C-r" 'search-backward)
    ;;(define-key evil-visual-state-map "\C-w" 'evil-delete)

    (define-key evil-motion-state-map (kbd ":") 'evil-repeat-find-char)
    (define-key evil-motion-state-map (kbd ";") 'evil-ex)
    (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
    (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
    (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
    (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)
    )
  )

(use-package evil-multiedit
  :ensure t
  :config
  (define-key evil-visual-state-map "R" 'evil-multiedit-match-all)
  (define-key evil-normal-state-map (kbd "M-d") 'evil-multiedit-match-symbol-and-next)
  (define-key evil-visual-state-map (kbd "M-d") 'evil-multiedit-match-and-next)
  (define-key evil-normal-state-map (kbd "M-D") 'evil-multiedit-match-symbol-and-prev)
  (define-key evil-visual-state-map (kbd "M-D") 'evil-multiedit-match-and-prev)
  (define-key evil-insert-state-map (kbd "M-d") 'evil-multiedit-toggle-marker-here)
  (define-key evil-visual-state-map (kbd "C-M-D") 'evil-multiedit-restore)
  (define-key evil-motion-state-map (kbd "RET") 'evil-multiedit-toggle-or-restrict-region)
  (define-key evil-multiedit-state-map (kbd "RET") 'evil-multiedit-toggle-or-restrict-region)
  (define-key evil-multiedit-state-map (kbd "C-n") 'evil-multiedit-next)
  (define-key evil-multiedit-state-map (kbd "C-p") 'evil-multiedit-prev)
  (define-key evil-multiedit-insert-state-map (kbd "C-n") 'evil-multiedit-next)
  (define-key evil-multiedit-insert-state-map (kbd "C-p") 'evil-multiedit-prev)
  (evil-ex-define-cmd "ie[dit]" 'evil-multiedit-ex-match)
  )

;; double rainbow... what does it all mean !!!!
(use-package rainbow-delimiters
  :ensure t
  :init
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

;; smart parens
(use-package smartparens :ensure t
  :init (smartparens-global-mode t)
  :config (require 'smartparens-config))

(use-package evil-smartparens
  :ensure t
  :init
  (add-hook 'smartparens-enabled-hook #'evil-smartparens-mode))

;; If you comment these two lines out, rainbow delimiters no longer work with
;; solarized, though they do still work with gruvbox.
;;(outline-minor-mode t)
;;(outline-minor-mode nil)


; setup golden-ration
(use-package golden-ratio
  :ensure t
  :diminish golden-ratio-mode
  :init
  (golden-ratio-mode 1))

(setq golden-ratio-extra-commands
      (append golden-ratio-extra-commands
	      '(evil-window-left
		evil-window-right
		evil-window-up
		evil-window-down
		buf-move-left
		buf-move-right
		buf-move-up
		buf-move-down
		window-number-select
		select-window
		select-window-1
		select-window-2
		select-window-3
		select-window-4
		select-window-5
		select-window-6
		select-window-7
		select-window-8
		select-window-9)
	      )
)



; configure additional packages
; install evil-surround
; http://wikemacs.org/wiki/Evil for more plugins

(use-package helm
  :ensure t
  :defer t
  :config
  (helm-mode 1)
  (setq helm-autoresize-mode t)
  (setq helm-buffer-max-length 40)
  (global-set-key (kbd "M-x") #'helm-M-x)
  (define-key helm-map (kbd "S-SPC") 'helm-toggle-visible-mark)
  (define-key helm-find-files-map (kbd "C-k") 'helm-find-files-up-one-level))

(use-package projectile
  :ensure t
  :defer t
  :config
  (projectile-global-mode))

(use-package helm-projectile
  :bind (("C-S-P" . helm-projectile-switch-project)
         :map evil-normal-state-map
         ("C-p" . helm-projectile))
  :ensure t
  :config
  (evil-leader/set-key
    "ps" 'helm-projectile-ag
    "pa" 'helm-projectile-find-file-in-known-projects
    ))

(use-package avy :ensure t)
(global-set-key (kbd "C-;") 'avy-goto-char)
(global-set-key (kbd "C-'") 'avy-goto-char-2)

(use-package yasnippet
  :ensure t
  :defer t
  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook #'yas-minor-mode)
  )

(use-package tern
  :ensure t)

(use-package auto-complete
  :ensure t
  :init
  (auto-complete-mode)
  :config
  (ac-config-default))

(use-package tern-auto-complete :ensure t)

(use-package js2-mode :ensure t :defer t)

(use-package js2-refactor
  :ensure t
  :defer t
  :init
  (add-hook 'js2-mode-hook #'js2-refactor-mode))

(add-hook 'js-mode-hook (lambda () (tern-mode t)))
(eval-after-load 'tern
   '(progn
      (require 'tern-auto-complete)
      (tern-ac-setup)))

(use-package go-mode :ensure t)

(setq custom-file (expand-file-name "go-autocomplete.el" user-emacs-directory))
   (when (file-exists-p custom-file)
     (load custom-file))

(use-package go-autocomplete :ensure t)
(use-package ac-dabbrev :ensure t)
(use-package fish-mode :ensure t)

(setq vc-follow-symlinks t)

; fix for solarized-dark bug in iterm2
; meant to the be last line in .emacs
;(custom-set-faces (if (not window-system) '(default ((t (:background "nil"))))))

(use-package esup :ensure t)
