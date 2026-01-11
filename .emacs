(load-theme 'tango-dark)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)

(repeat-mode t)
(save-place-mode t)
(savehist-mode t)
(column-number-mode t)

(setq inhibit-splash-screen t)
(setq backup-directory-alist '(("." . "~/emacs_backups")))
(setq enable-recursive-minibuffers t)
(setq read-extended-command-predicate #'command-completion-default-include-p)
(setq minibuffer-prompt-properties '(read-only t cursor-intangible t face minibuffer-prompt))
(setq read-file-name-completion-ignore-case t)
(setq read-buffer-completion-ignore-case t)
(setq completion-ignore-case t)

(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'relative)
(dolist (mode '(shell-mode-hook
                eshell-mode-hook
                term-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(setq compilation-scroll-output t)
(setq compilation-max-output-line-length nil)
(setq compilation-auto-jump-to-first-error t)
(setq dired-dwim-target 'dired-dwim-target-recent)
(setq dired-listing-switches "-lah")
(setq dired-mouse-drag-files t)

(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

(dolist (item '((font . "JetbrainsMono Nerd Font-15")
		        (fullscreen . maximized)))
  (add-to-list 'default-frame-alist item))

(setq custom-file "~/.emacs.custom.el")
(load custom-file)

(global-set-key (kbd "C-c b") 'recompile)
(global-set-key (kbd "C-c m") 'man)

(defun my/duplicate-line ()
  (interactive)
  (let ((column (- (point) (point-at-bol)))
        (line (let ((s (thing-at-point 'line t)))
                (if s (string-remove-suffix "\n" s) ""))))
    (move-end-of-line 1)
    (newline)
    (insert line)
    (move-beginning-of-line 1)
    (forward-char column)))
(global-set-key (kbd "C-,") 'my/duplicate-line)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(require 'use-package)
(setq use-package-always-ensure t)

(use-package company
  :hook (after-init . global-company-mode)
  :bind ("C-." . company-complete)
  :init
  (setq company-idle-delay 0)
  (setq company-selection-wrap-around t)
  (setq company-tooltip-maximum-width 50)
  (setq company-minimum-prefix-length 1)
  (setq company-backends '((company-capf :separate company-dabbrev-code)
                           company-files)))

(use-package yasnippet :config (yas-global-mode t))

(use-package multiple-cursors
  :bind (("C->"         . mc/mark-next-like-this)
		 ("C-<"         . mc/mark-previous-like-this)
		 ("C-c C-<"     . mc/mark-all-like-this)
		 ("C-S-c C-S-c" . mc/edit-lines)
		 ("C-\""        . mc/skip-to-next-like-this)
		 ("C-:"         . mc/skip-to-previous-like-this)))

(use-package vertico
  :custom (vertico-cycle t)
  :init (vertico-mode))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-pcm-leading-wildcard t))

(use-package marginalia
  :init (marginalia-mode))

(use-package magit :bind ("C-x g" . magit-status))
(use-package vundo)

(defun my/enable-eglot ()
  (unless (> (buffer-size) (* 2 1024 1024))
    (eglot-ensure)))

(use-package eglot
  :hook (prog-mode . my/enable-eglot)
  :bind (:map eglot-mode-map
              ("C-c l r" . eglot-rename)
              ("C-c l a" . eglot-code-actions)
              ("C-c l h" . eldoc)
              ("C-c l f" . eglot-format)
              ("M-n"     . flymake-goto-next-error)
              ("M-p"     . flymake-goto-prev-error))
  :config
  (setq eglot-ignored-server-capabilities '(:inlayHintProvider))
  (add-to-list 'eglot-stay-out-of 'company-backends)
  (add-to-list 'eglot-server-programs
               '((c-mode c++-mode)
                 . ("clangd"
                    "--background-index"
                    "--header-insertion=never"
                    "--completion-style=detailed"
                    "--function-arg-placeholders=1"))))

(add-hook 'c-mode-hook (lambda ()
                         (c-toggle-comment-style -1)
                         (setq c-basic-offset 4)))
