;;; -*- lexical-binding: t -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(async-bytecomp-package-mode t)
 '(backup-directory-alist '(("." . "~/emacs_backups")))
 '(blink-cursor-mode nil)
 '(c-default-style "file")
 '(c-syntactic-indentation nil)
 '(c-tab-always-indent nil)
 '(column-number-mode t)
 '(company-backends
   '(company-files company-cmake company-capf company-clang
                   (company-dabbrev-code company-gtags company-etags
                                         company-keywords)
                   company-dabbrev))
 '(company-dabbrev-code-ignore-case t)
 '(company-dabbrev-ignore-case t)
 '(company-etags-ignore-case t)
 '(company-idle-delay 0)
 '(company-keywords-ignore-case t)
 '(company-minimum-prefix-length 1)
 '(company-selection-wrap-around t)
 '(company-tooltip-maximum-width 50)
 '(compilation-always-kill t)
 '(compilation-max-output-line-length nil)
 '(compilation-scroll-output t)
 '(completion-auto-help t)
 '(completion-auto-select 'second-tab)
 '(completion-category-overrides '((file (styles partial-completion))))
 '(completion-styles '(orderless basic))
 '(completions-format 'one-column)
 '(completions-max-height 15)
 '(completions-sort 'historical)
 '(create-lockfiles nil)
 '(custom-enabled-themes '(dracula))
 '(custom-safe-themes
   '("9c6aa7eb1bde73ba1142041e628827492bd05678df4d9097cda21b1ebcb8f8b9"
     default))
 '(default-frame-alist
   '((fullscreen . maximized) (font . "JetbrainsMono Nerd Font-15")))
 '(delete-by-moving-to-trash t)
 '(delete-old-versions t)
 '(delete-selection-mode t)
 '(dired-async-mode t)
 '(dired-auto-revert-buffer t)
 '(dired-create-destination-dirs 'always)
 '(dired-create-destination-dirs-on-trailing-dirsep t)
 '(dired-do-revert-buffer t)
 '(dired-dwim-target 'dired-dwim-target-recent)
 '(dired-listing-switches "-lavh --group-directories-first")
 '(dired-subtree-after-insert-hook '(dired-subtree--after-insert))
 '(dired-subtree-use-backgrounds nil)
 '(direnv-mode t)
 '(display-buffer-alist
   '(("\\`\\*\\(Warnings\\|Compile-Log\\)\\*\\'"
      (display-buffer-no-window) (allow-no-window . t))))
 '(display-line-numbers-type 'relative)
 '(eglot-autoshutdown t)
 '(eglot-ignored-server-capabilities '(:documentOnTypeFormattingProvider :inlayHintProvider))
 '(eglot-report-progress nil)
 '(eldoc-echo-area-use-multiline-p nil)
 '(enable-recursive-minibuffers t)
 '(global-auto-revert-mode t)
 '(global-company-mode t)
 '(global-display-line-numbers-mode t)
 '(global-hl-line-mode t)
 '(grep-find-ignored-directories
   '("SCCS" "RCS" "CVS" "MCVS" ".src" ".svn" ".git" ".hg" ".bzr" "_MTN"
     "_darcs" "{arch}" ".venv" "venv" "node_modules" ".vscode" "build"
     ".cache"))
 '(help-window-select t)
 '(history-delete-duplicates t)
 '(history-length t)
 '(imenu-auto-rescan t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(kept-new-versions 6)
 '(marginalia-mode t)
 '(menu-bar-mode nil)
 '(minibuffer-prompt-properties '(read-only t face minibuffer-prompt cursor-intangible t))
 '(orderless-component-separator " +\\|[-/]")
 '(package-archive-priorities '(("gnu" . 5) ("nongnu" . 5) ("melpa" . 0)))
 '(package-archives
   '(("gnu" . "https://elpa.gnu.org/packages/")
     ("nongnu" . "https://elpa.nongnu.org/nongnu/")
     ("melpa" . "https://melpa.org/packages/")))
 '(package-native-compile t)
 '(package-quickstart t)
 '(package-selected-packages
   '(async cmake-mode company devdocs dired-subtree direnv dracula-theme
           magit marginalia markdown-mode mason multiple-cursors
           orderless ruff-format shfmt vertico vterm vundo yasnippet))
 '(read-buffer-completion-ignore-case t)
 '(read-extended-command-predicate 'command-completion-default-include-p)
 '(read-file-name-completion-ignore-case t)
 '(recentf-auto-cleanup 'never)
 '(recentf-max-saved-items 99999)
 '(recentf-mode t)
 '(repeat-mode t)
 '(save-place-mode t)
 '(savehist-mode t)
 '(scroll-bar-mode nil)
 '(tab-always-indent nil)
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(trash-directory "~/.Trash")
 '(use-short-answers t)
 '(vertico-cycle t)
 '(vertico-mode t)
 '(vterm-always-compile-module t)
 '(vterm-max-scrollback 10000))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
