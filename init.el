;; Packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; UI
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(load-theme 'modus-vivendi t)

(setq inhibit-startup-message t
      initial-scratch-message ";; Happy hacking!\n")

(line-number-mode 1)
(column-number-mode 1)

;; Files
(defconst backup-dir
  (expand-file-name "backups/" user-emacs-directory))

(make-directory backup-dir t)

(setq backup-directory-alist
      `(("." . ,backup-dir))
      auto-save-file-name-transforms
      `((".*" ,backup-dir t))
      lock-file-name-transforms
      `((".*" ,backup-dir t)))

;; Custom settings
(setq custom-file
      (expand-file-name "custom.el" user-emacs-directory))

(when (file-exists-p custom-file)
  (load custom-file))

;; Completion
(fido-mode 1)

;; Magit
(use-package magit
  :bind (("C-x g"   . magit-status)
         ("C-c g g" . magit-status)
         ("C-c g l" . magit-log-current)
         ("C-c g b" . magit-blame-addition))
  :config
  ;; Use the current window for Magit status.
  (setq magit-display-buffer-function
        #'magit-display-buffer-same-window-except-diff-v1)

  ;; Make hunks show word-level changes.
  (setq magit-diff-refine-hunk 'all)

  ;; Refresh Magit buffers after Git operations.
  (setq magit-refresh-status-buffer t))

;; Indentation

(defun setup-programming-indentation ()
  (setq-local indent-tabs-mode nil
              tab-width 4))

(defun setup-python-indentation ()
  (setup-programming-indentation)
  (setq-local python-indent-offset 4))

(defun setup-c-cpp-indentation ()
  (setup-programming-indentation)
  (setq-local c-basic-offset 4))

(defun setup-rust-indentation ()
  (setup-programming-indentation)
  (setq-local rust-indent-offset 4))

(add-hook 'python-mode-hook #'setup-python-indentation)
(add-hook 'python-ts-mode-hook #'setup-python-indentation)

(add-hook 'c-mode-hook #'setup-c-cpp-indentation)
(add-hook 'c++-mode-hook #'setup-c-cpp-indentation)

(add-hook 'rust-mode-hook #'setup-rust-indentation)
(add-hook 'rust-ts-mode-hook #'setup-rust-indentation)

;; Remove whitespaces
(with-eval-after-load 'files
  (add-hook 'before-save-hook #'delete-trailing-whitespace))
