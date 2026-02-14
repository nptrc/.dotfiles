;;; -*- lexical-binding: t -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(backup-directory-alist '(("." . "~/emacs_backups")))
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(company-backends
   '((company-capf :separate company-dabbrev-code) company-files))
 '(company-dabbrev-code-ignore-case t)
 '(company-dabbrev-ignore-case t)
 '(company-idle-delay 0)
 '(company-minimum-prefix-length 1)
 '(company-selection-wrap-around t)
 '(company-tooltip-maximum-width 50)
 '(compilation-auto-jump-to-first-error t)
 '(compilation-max-output-line-length nil)
 '(compilation-scroll-output t)
 '(completion-category-overrides '((file (styles partial-completion))))
 '(completion-styles '(orderless basic))
 '(default-frame-alist
   '((fullscreen . maximized) (font . "JetbrainsMono Nerd Font-15")))
 '(delete-by-moving-to-trash t)
 '(delete-selection-mode t)
 '(dired-dwim-target 'dired-dwim-target-recent)
 '(dired-listing-switches "-lah")
 '(dired-mouse-drag-files t)
 '(display-line-numbers-type 'relative)
 '(eglot-autoshutdown t)
 '(eglot-events-buffer-config '(:size 0 :format full))
 '(eglot-ignored-server-capabilities '(:inlayHintProvider))
 '(eglot-report-progress nil)
 '(enable-recursive-minibuffers t)
 '(global-auto-revert-mode t)
 '(global-company-mode t)
 '(global-display-line-numbers-mode t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(marginalia-mode t)
 '(menu-bar-mode nil)
 '(minibuffer-prompt-properties '(read-only t face minibuffer-prompt cursor-intangible t))
 '(orderless-component-separator " +\\|[-/]")
 '(package-archives
   '(("gnu" . "https://elpa.gnu.org/packages/")
     ("nongnu" . "https://elpa.nongnu.org/nongnu/")
     ("melpa" . "https://melpa.org/packages/")))
 '(package-selected-packages
   '(company magit marginalia mason multiple-cursors orderless vertico
             vundo yasnippet))
 '(read-buffer-completion-ignore-case t)
 '(read-extended-command-predicate 'command-completion-default-include-p)
 '(read-file-name-completion-ignore-case t)
 '(repeat-mode t)
 '(save-place-mode t)
 '(savehist-mode t)
 '(scroll-bar-mode nil)
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(trash-directory "~/.Trash")
 '(use-package-always-ensure t)
 '(use-short-answers t)
 '(vertico-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
