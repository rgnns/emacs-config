;;; gamma-defaults.el --- Gamma defaults

(setq
 ad-redefinition-action 'accept
 ansi-color-for-comint-mode t
 auto-fill-mode nil
 auto-window-vscroll nil
 c-basic-offset 2
 confirm-nonexistent-file-or-buffer nil
 create-lockfiles nil
 css-indent-offset 2
 default-major-mode 'text-mode
 enable-recursive-minibuffers t
 fill-column 120
 font-lock-maximum-decoration nil
 font-lock-maximum-size nil
 frame-resize-pixelwise t
 frame-title-format nil
 inhibit-compacting-font-caches t
 inhibit-startup-echo-area-message t
 inhibit-startup-message t
 inhibit-startup-screen t
 initial-buffer-choice nil
 initial-major-mode 'text-mode
 initial-scratch-message nil
 isearch-allow-scroll t
 js-indent-level 2
 max-lisp-eval-depth 32768
 max-special-size 8192
 mouse-yank-at-point t
 pop-up-windows nil
 read-process-output-max (* 1024 1024)
 require-final-newline t
 ring-bell-function 'ignore
 save-interprogram-paste-before-kill t
 scroll-conservatively 100000
 scroll-margin 0
 scroll-preserve-screen-position 1
 search-default-mode 'char-fold-to-regexp
 sentence-end-double-space nil
 split-height-threshold 120
 split-width-threshold 180
 tab-always-indent 'complete
 truncate-string-ellipsis "…"
 use-dialog-box nil
 use-file-dialog nil
 visible-bell t)

(setq-default
 indent-tabs-mode nil
 tab-width 2
 display-line-numbers-width 3
 display-line-numbers/widen t)

(define-coding-system-alias 'UTF-8 'utf-8)
(prefer-coding-system 'utf-8)
(setq
 locale-coding-system 'utf-8
 default-processing-coding-system '(utf-8-unix . utf-8-unix))
(set-charset-priority 'unicode)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)

(delete-selection-mode t)
(fset 'yes-or-no-p 'y-or-n-p)
(global-hl-line-mode +1)
(line-number-mode t)
(put 'downcase-region 'disabled nil)
(put 'erase-buffer 'disabled nil)
(put 'narrow-to-defun 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'scroll-left 'disabled nil)
(put 'upcase-region 'disabled nil)
(size-indication-mode t)
(make-variable-buffer-local 'global-hl-line-hightlight)
(defvar gamma--ghd-modes '(shell-mode-hook
			   git-commit-mode-hook
			   term-mode-hook)
  "Modes to ensure global-hl-line-mode is disabled for.")
(dolist (m gamma--ghd-modes)
  (add-hook m (lambda () (setq global-hl-line-mode nil))))

(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'text-mode-hook #'display-line-numbers-mode)
(add-hook 'conf-mode-hook #'display-line-numbers-mode)

(use-package custom
  :no-require t
  :custom
  (custom-file (expand-file-name "custom.el" user-emacs-directory))
  :config
  (when (file-exists-p custom-file) (load custom-file 'noerror)))

(use-package no-littering
  :demand t
  :config
  (setq mc/list-file (no-littering-expand-etc-file-name "mc-list.el")
	auto-save-file-name-transforms
	`((".*" ,(no-littering-expand-var-file-name "auto-save/") t))))

(use-package recentf
  :demand t
  :custom
  (recentf-max-saved-items 200)
  :config
  (add-to-list 'recentf-exclude "^/\\(?:ssh\\|su\\|sudo\\)?:")
  (add-to-list 'recentf-exclude "\\.(gz|xz|zip)")
  (add-to-list 'recentf-exclude "/elpa/")
  (recentf-mode 1))

(use-package savehist :config (savehist-mode))

(use-package simple :config (column-number-mode))

(use-package tramp
  :defer t
  :config
  (add-to-list 'tramp-default-proxies-alist '(nil "\\`root\\'" "/ssh:%h:"))
  (add-to-list 'tramp-default-proxies-alist '("localhost" nil nil))
  (add-to-list 'tramp-dfeault-proxies-alist
	       (list (regexp-quote (system-name)) nil nil))
  (setq vc-ignore-dir-regexp
	(format "\\(%s\\)\\|\\(%s\\)"
		vc-ignore-dir-regexp
		tramp-file-name-regexp)))

(let ((inhibit-message t))
  (message "Welcome to GNU Emacs | G Λ M M Λ edition")
  (message (format "Initialization time: %s" (emacs-init-time))))

(provide 'gamma-defaults)

;;; gamma-defaults.el ends here
