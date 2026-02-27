(setq custom-file "~/.emacs.custom.el")
(load custom-file)

(defun save-all-buffers ()
  (interactive)
  (save-some-buffers t))
(add-hook 'focus-out-hook 'save-all-buffers)

(defun my/turn-off-vc-for-remote-files ()
  (when (file-remote-p (buffer-file-name))
    (setq-local vc-handled-backends nil)))
(add-hook 'find-file-hook 'my/turn-off-vc-for-remote-files)

(defun my/cleanup-buffer-file ()
  (interactive)
  (ignore-errors
    (unless (or (equal major-mode 'makefile-mode)
                (equal major-mode 'makefile-bsdmake-mode))
      (untabify (point-min) (point-max)))
    (delete-trailing-whitespace)))
(add-hook 'before-save-hook #'my/cleanup-buffer-file)

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
(global-set-key (kbd "C-,")         'my/duplicate-line)

(add-hook 'vterm-mode-hook (lambda () (display-line-numbers-mode -1)))

(add-hook 'compilation-filter-hook  'ansi-color-compilation-filter)
(global-set-key (kbd "C-c b")       'recompile)

(global-set-key (kbd "C-c m")       'man)

(require 'package)
(package-initialize)
(unless package-archive-contents (package-refresh-contents))
(package-install-selected-packages)

(global-set-key (kbd "C-x g")       'magit-status)

(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C-'")         'mc/skip-to-next-like-this)
(global-set-key (kbd "C-;")         'mc/skip-to-previous-like-this)

(add-hook 'rfn-eshadow-update-overlay-hook #'vertico-directory-tidy)

(setq vterm-timer-delay 0.01)

(global-set-key (kbd "C-.") 'company-complete)
(setq completion-ignore-case t)

(mason-setup
  (dolist (pkg '("clangd" "clang-format" "neocmakelsp"
                 "pyright" "ruff"))
    (unless (mason-installed-p pkg)
      (ignore-errors (mason-install pkg)))))

(with-eval-after-load 'eglot
  (define-key eglot-mode-map (kbd "C-c l r") #'eglot-rename)
  (define-key eglot-mode-map (kbd "C-c l a") #'eglot-code-actions)
  (define-key eglot-mode-map (kbd "C-c l f") #'eglot-format)
  (define-key eglot-mode-map (kbd "C-c l x") #'flymake-show-buffer-diagnostics)
  (define-key eglot-mode-map (kbd "C-c l p") #'flymake-show-project-diagnostics)

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
(add-hook 'c-mode-common-hook #'my/enable-eglot)
(add-hook 'python-mode-hook #'my/enable-eglot)
(add-hook 'cmake-mode-hook #'my/enable-eglot)

(add-hook 'c-mode-common-hook
          (lambda ()
            (c-toggle-comment-style -1)
            (setq c-basic-offset 4)))

(add-to-list 'auto-mode-alist '("[Mm]akefile\\'" . makefile-mode))
(add-hook 'makefile-mode-hook
          (lambda ()
            (setq indent-tabs-mode t)))
