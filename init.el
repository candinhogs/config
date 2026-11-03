;;; -*- lexical-binding: t -*-
;; Packages
(require 'package)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/")
             t)

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(setq use-package-always-ensure t)

;; UI
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(load-theme 'modus-vivendi t)

(setq inhibit-startup-message t
      initial-scratch-message ";; Happy hacking!\n")

(line-number-mode 1)
(column-number-mode 1)
(show-paren-mode 1)

;; Files
(defconst backup-dir
  (expand-file-name "backups/" user-emacs-directory))

(make-directory backup-dir t)

(setq backup-directory-alist
      `(("." . ,backup-dir))
      auto-save-file-name-transforms
      `(("." ,backup-dir t))
      lock-file-name-transforms
      `(("." ,backup-dir t))
      make-backup-files t
      version-control t
      kept-new-versions 6
      kept-old-versions 2
      delete-old-versions t)

(setq custom-file
      (expand-file-name "custom.el" user-emacs-directory))

(when (file-exists-p custom-file)
  (load custom-file))

;; Completion
(fido-mode 1)

;; Editing
(setq-default indent-tabs-mode nil
              tab-width 4
              truncate-lines nil)

(electric-pair-mode 1)
(save-place-mode 1)

(add-hook 'before-save-hook
          #'delete-trailing-whitespace)

;; Magit
(use-package magit
  :bind (("C-x g" . magit-status)
         ("C-c g g" . magit-status)
         ("C-c g l" . magit-log-current)
         ("C-c g b" . magit-blame-addition))
  :config
  (setq magit-display-buffer-function
        #'magit-display-buffer-same-window-except-diff-v1
        magit-diff-refine-hunk 'all))

;; Python
(defun setup-python-indentation ()
  (setq-local indent-tabs-mode nil
              tab-width 4
              python-indent-offset 4))

(add-hook 'python-mode-hook
          #'setup-python-indentation)

(add-hook 'python-ts-mode-hook
          #'setup-python-indentation)

;; Nael
(use-package nael
  :mode ("\\.lean\\'" . nael-mode))
