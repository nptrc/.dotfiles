;;; -*- lexical-binding: t -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(backup-directory-alist '(("." . "~/emacs_backups")))
 '(blink-cursor-mode nil)
 '(c-syntactic-indentation nil)
 '(c-tab-always-indent nil)
 '(column-number-mode t)
 '(company-backends
   '((company-capf :separate company-dabbrev-code) company-files))
 '(company-dabbrev-code-ignore-case t)
 '(company-dabbrev-ignore-case t)
 '(company-idle-delay 0)
 '(company-minimum-prefix-length 1)
 '(company-selection-wrap-around t)
 '(company-tooltip-maximum-width 50)
 '(compilation-max-output-line-length nil)
 '(compilation-scroll-output t)
 '(completion-category-overrides '((file (styles partial-completion))))
 '(completion-styles '(orderless basic))
 '(create-lockfiles nil)
 '(custom-enabled-themes '(dracula tango-dark))
 '(custom-safe-themes
   '("0223215a464167d93b9cfef9b1cdf9b0768ab660f33b3068b647f7b12aa453a0"
     "9c6aa7eb1bde73ba1142041e628827492bd05678df4d9097cda21b1ebcb8f8b9"
     "2d74de1cc32d00b20b347f2d0037b945a4158004f99877630afc034a674e3ab7"
     default))
 '(default-frame-alist
   '((fullscreen . maximized) (font . "JetbrainsMono Nerd Font-15")))
 '(delete-by-moving-to-trash t)
 '(delete-old-versions t)
 '(delete-selection-mode t)
 '(dired-dwim-target 'dired-dwim-target-recent)
 '(dired-listing-switches "-lavh --group-directories-first")
 '(dired-mouse-drag-files t)
 '(display-line-numbers-type 'relative)
 '(eglot-autoshutdown t)
 '(eglot-events-buffer-config '(:size 0 :format full))
 '(eglot-ignored-server-capabilities '(:documentOnTypeFormattingProvider :inlayHintProvider))
 '(eglot-report-progress nil)
 '(enable-recursive-minibuffers t)
 '(global-auto-revert-mode t)
 '(global-company-mode t)
 '(global-display-line-numbers-mode t)
 '(imenu-auto-rescan t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(kept-new-versions 6)
 '(marginalia-mode t)
 '(menu-bar-mode nil)
 '(minibuffer-prompt-properties '(read-only t face minibuffer-prompt cursor-intangible t))
 '(orderless-component-separator " +\\|[-/]")
 '(package-archive-priorities '(("gnu" . 10) ("melpa" . 5)))
 '(package-archives
   '(("gnu" . "https://elpa.gnu.org/packages/")
     ("nongnu" . "https://elpa.nongnu.org/nongnu/")
     ("melpa" . "https://melpa.org/packages/")))
 '(package-selected-packages
   '(company devdocs dracula-theme magit marginalia mason
             multiple-cursors orderless vertico vterm vundo yasnippet))
 '(read-buffer-completion-ignore-case t)
 '(read-extended-command-predicate 'command-completion-default-include-p)
 '(read-file-name-completion-ignore-case t)
 '(recentf-auto-cleanup 'never)
 '(recentf-mode t)
 '(remote-file-name-inhibit-locks t)
 '(repeat-mode t)
 '(save-place-mode t)
 '(savehist-mode t)
 '(scroll-bar-mode nil)
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(trash-directory "~/.Trash")
 '(use-package-always-ensure t)
 '(use-short-answers t)
 '(vertico-cycle t)
 '(vertico-mode t)
 '(vterm-max-scrollback 10000))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
