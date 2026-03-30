(setq custom-file "~/.emacs.custom.el")
(load custom-file)

(setq completion-ignore-case t)
(setq completion-category-defaults nil)

(defun me/keyboard-quit-dwim ()
  (interactive)
  (cond
   ((region-active-p)
    (keyboard-quit))
   ((derived-mode-p 'completion-list-mode)
    (delete-completion-window))
   ((> (minibuffer-depth) 0)
    (abort-recursive-edit))
   (t
    (keyboard-quit))))
(define-key global-map (kbd "C-g") 'me/keyboard-quit-dwim)

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

(defun my/cleanup-buffer-file ()
  (interactive)
  (ignore-errors
    (unless (or (equal major-mode 'makefile-mode)
                (equal major-mode 'makefile-bsdmake-mode))
      (untabify (point-min) (point-max)))
    (delete-trailing-whitespace)))
(add-hook 'before-save-hook 'my/cleanup-buffer-file)

(global-set-key (kbd "C-x 2") (lambda ()
                                (interactive)
                                (split-window-vertically)
                                (other-window 1)))
(global-set-key (kbd "C-x 3") (lambda ()
                                (interactive)
                                (split-window-horizontally)
                                (other-window 1)))

(add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)
(global-set-key (kbd "C-c b")      'recompile)

(global-set-key (kbd "C-c m") 'man)

(global-set-key (kbd "<f1>") 'delete-other-windows)

(package-initialize)
(unless package-archive-contents (package-refresh-contents))
(package-install-selected-packages)

(global-set-key (kbd "C-.") 'company-complete)

(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "TAB") 'dired-subtree-toggle)
  (define-key dired-mode-map (kbd "DEL") 'dired-subtree-remove))

(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C-'")         'mc/skip-to-next-like-this)
(global-set-key (kbd "C-;")         'mc/skip-to-previous-like-this)

(add-hook 'rfn-eshadow-update-overlay-hook 'vertico-directory-tidy)

(setq vterm-timer-delay 0.01)
(add-hook 'vterm-mode-hook (lambda ()
                             (display-line-numbers-mode -1)
                             (setq-local global-hl-line-mode nil)))

(mason-setup
 (dolist (pkg '("clangd" "clang-format"
                "neocmakelsp" "cmakelang"
                "pyright" "ruff"
                "bash-language-server" "shfmt"))
   (unless (mason-installed-p pkg)
     (ignore-errors (mason-install pkg)))))

(with-eval-after-load 'eglot
  (define-key eglot-mode-map (kbd "C-c l r") 'eglot-rename)
  (define-key eglot-mode-map (kbd "C-c l a") 'eglot-code-actions)
  (define-key eglot-mode-map (kbd "C-c l f") 'eglot-format)
  (define-key eglot-mode-map (kbd "C-c l x") 'flymake-show-buffer-diagnostics)
  (define-key eglot-mode-map (kbd "C-c l p") 'flymake-show-project-diagnostics)

  (add-to-list 'eglot-stay-out-of 'company-backends)
  (dolist (entry
           '(((c-mode c++-mode) . ("clangd"
                                   "--background-index"
                                   "--header-insertion=never"
                                   "--completion-style=detailed"
                                   "--function-arg-placeholders=1"))
             ((cmake-mode) . ("neocmakelsp" "stdio"))))
    (add-to-list 'eglot-server-programs entry)))

(defun my/enable-eglot ()
  (unless (> (buffer-size) (* 2 1024 1024))
    (eglot-ensure)))
(add-hook 'c-mode-common-hook 'my/enable-eglot)
(add-hook 'python-mode-hook   'my/enable-eglot)
(add-hook 'cmake-mode-hook    'my/enable-eglot)
(add-hook 'sh-mode-hook       'my/enable-eglot)

(add-hook 'c-mode-common-hook
          (lambda ()
            (c-toggle-comment-style -1)))

(add-to-list 'auto-mode-alist '("[Mm]akefile\\'" . makefile-mode))
(add-hook 'makefile-mode-hook
          (lambda ()
            (setq indent-tabs-mode t)))
