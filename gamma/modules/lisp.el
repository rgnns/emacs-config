;;; lisp.el --- Gamma LISP dialects

(use-package lisp-mode
  :preface
  (defun indent-spaces-mode ()
    (setq indent-tabs-mode nil))
  :config
  (add-hook 'emacs-lisp-mode-hook 'outline-minor-mode)
  (add-hook 'emacs-lisp-mode-hook 'reveal-mode)
  (add-hook 'lisp-interaction-mode-hook 'indent-spaces-mode))

(use-package paredit
  :diminish paredit-mode
  :bind (("C-c d" . paredit-forward-down))
  :config
  (add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
  (add-hook 'ielm-mode-hook #'enable-paredit-mode)
  (add-hook 'lisp-mode-hook #'enable-paredit-mode)
  (add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
  (add-hook 'scheme-mode-hook #'enable-paredit-mode))

(use-package paredit-everywhere
  :diminish paredit-everywhere
  :config
  (add-hook 'list-mode-hook #'paredit-everywhere-mode))

(use-package paren :config (show-paren-mode))

;;; lisp.el ends here
