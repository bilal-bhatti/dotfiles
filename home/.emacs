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

;; ensure use-package 
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))

;; init exec-path from shell path
;;(use-package exec-path-from-shell :ensure t)
;;(when (memq window-system '(mac ns x))
;;  (exec-path-from-shell-initialize))
(setenv "PATH" (concat (getenv "PATH") ":/Users/bilal/Projects/Go/bin"))
(setq exec-path (append exec-path '("/Users/bilal/Projects/Go/bin")))

;; set custom file for customizations
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; no backup files
(setq make-backup-files nil)

;; If in gui, or else
(setq ns-pop-up-frames nil)
(if (display-graphic-p)
    (progn
      ;; disable scroll bars
      (scroll-bar-mode -1)
      (tool-bar-mode -1)

      ;; set default font
      (let ((fontset "fontset-default"))
	(set-fontset-font fontset 'latin '("Source Code Pro for Powerline"))
	(set-face-attribute 'default nil
			    :font fontset
			    :weight 'semi-bold
			    :height 130))
      (defun get-default-height ()
	(/ (- (display-pixel-height) 100)
	   (frame-char-height)))
      (add-to-list 'default-frame-alist '(width . 120))
      (add-to-list 'default-frame-alist (cons 'height (get-default-height)))
      )
  )

;; set appearance settings
(fset 'yes-or-no-p 'y-or-n-p)
(setq inhibit-startup-screen t)
(x-focus-frame nil)
(setq visible-bell 1)
(global-linum-mode 1)
(setq linum-format "%4d \u2502")
(global-hl-line-mode)
(setq c-basic-offset 4) ; indents 4 chars
(setq tab-width 4)          ; and 4 char wide for TAB
(setq indent-tabs-mode nil) ; And force use of spaces
(setq vc-follow-symlinks t)
(setq scroll-margin 5 scroll-conservatively 9999 scroll-step 1)
(use-package hlinum :ensure t :init (hlinum-activate))

;; load solarized theme from elpa
(use-package solarized-theme
  :ensure t
  :defer t
  :init
  (load-theme 'solarized-dark t))

;; change cursor color depending on mode
(setq evil-emacs-state-cursor '("#DC322F" box))
(setq evil-normal-state-cursor '("#859900" box))
(setq evil-visual-state-cursor '("#CB4B16" box))
(setq evil-insert-state-cursor '("#DC322F" bar))
(setq evil-replace-state-cursor '("#DC322F" bar))
(setq evil-operator-state-cursor '("#DC322F" hollow))

;; setup parentheses highlighging
(show-paren-mode 1)
(setq show-paren-style 'parenthesis)

;; enable evil leader, before evil mode
(use-package evil-leader
  :ensure t
  :init
  (global-evil-leader-mode)
  :config
  (evil-leader/set-leader ",")
  (evil-leader/set-key
    "e" 'find-file
    "k" 'kill-buffer)
  )
(setq evil-leader/in-all-states 1)

;; configure evil mode
(use-package evil
  :ensure t
  :config
  (evil-mode t)
  (evil-select-search-module 'evil-search-module 'evil-search))

;; https://github.com/davvil/.emacs.d/blob/master/init.el
(defun minibuffer-keyboard-quit ()
  (interactive)
  (if (and delete-selection-mode transient-mark-mode-hook mark-active)
      (seq deactivate-mark t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))

;; set escape to exit various states instead of C-g
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(define-key evil-ex-search-keymap (kbd "<escape>") 'minibuffer-keyboard-quit)
(global-set-key [escape] 'evil-exit-emacs-state)

;; evil: bring back basic emacs command
(define-key evil-normal-state-map "\C-y" 'yank)
(define-key evil-insert-state-map "\C-y" 'yank)
(define-key evil-visual-state-map "\C-y" 'yank)
(define-key evil-insert-state-map "\C-e" 'end-of-line)
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
 
(use-package evil-multiedit
  :ensure t
  :config
  (define-key evil-visual-state-map "R" 'evil-multiedit-match-all)
  (define-key evil-normal-state-map (kbd "M-d") 'evil-multiedit-match-symbol-and-next)
  (define-key evil-visual-state-map (kbd "M-d") 'evil-multiedit-match-and-next)
  (define-key evil-normal-state-map (kbd "M-D") 'evil-multiedit-match-symbol-and-prev)
  (define-key evil-visual-state-map (kbd "M-D") 'evil-multiedit-match-and-prev)
  (define-key evil-insert-state-map (kbd "M-d") 'evil-multiedit-toggle-marker-here)
  ;;(define-key evil-visual-state-map (kbd "C-M-D") 'evil-multiedit-restore)
  ;;(define-key evil-motion-state-map (kbd "RET") 'evil-multiedit-toggle-or-restrict-region)
  ;;(define-key evil-multiedit-state-map (kbd "RET") 'evil-multiedit-toggle-or-restrict-region)
  ;;(define-key evil-multiedit-state-map (kbd "C-n") 'evil-multiedit-next)
  ;;(define-key evil-multiedit-state-map (kbd "C-p") 'evil-multiedit-prev)
  ;;(define-key evil-multiedit-insert-state-map (kbd "C-n") 'evil-multiedit-next)
  ;;(define-key evil-multiedit-insert-state-map (kbd "C-p") 'evil-multiedit-prev)
  ;;(evil-ex-define-cmd "ie[dit]" 'evil-multiedit-ex-match)
  )

;; install evil-tabs
(use-package evil-tabs
  :ensure t
  :config
  (global-evil-tabs-mode t))

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

(use-package helm
  :ensure t
  :init
  (helm-mode 1)
  :config
  (setq helm-autoresize-mode 1)
  (setq helm-buffer-max-length 40)
  (setq helm-buffers-fuzzy-matching t)
  (evil-leader/set-key "l" 'helm-mini))

(use-package helm-flx :ensure t :init (helm-flx-mode +1))
(setq helm-flx-for-helm-find-files t
      helm-flx-for-helm-locate t)

(use-package helm-fuzzier :ensure t :config (helm-fuzzier-mode 1))

(use-package projectile
  :ensure t
  :defer t
  :config
  (projectile-global-mode))

(use-package helm-projectile
  :ensure t
  :init
  (helm-projectile-on)
  :bind(:map evil-normal-state-map ("C-p" . helm-projectile))
  :config
  (evil-leader/set-key "f" 'helm-projectile))

(use-package avy
  :ensure t
  :config
  (evil-leader/set-key "," 'avy-goto-char-2)
  )

(use-package yasnippet
  :ensure t
  :defer t
  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook #'yas-minor-mode)
  )

(use-package auto-complete
  :ensure t
  :init
  (auto-complete-mode)
  :config
  (ac-config-default))

(use-package js2-mode :ensure t :defer t)
(use-package go-mode :ensure t)
(use-package go-autocomplete :ensure t)
(use-package ac-dabbrev :ensure t)
(use-package fish-mode :ensure t)
 
(load "server")
(unless (server-running-p) (server-start))

