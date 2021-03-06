;;; gamma-dev.el --- Gamma for developers

(setq-default sh-basic-offset 2)

;; Use ~ to represent variables to be replaced and call `aya-create' on that line.
;; Use `aya-expand' to paste. `format' also works.
(use-package auto-yasnippet
  :after yasnippet
  :bind (("C-c y a" . aya-create)
         ("C-c y e" . aya-expand)
         ("C-c y o" . aya-open-line)))

(use-package company
  :defer 5
  :diminish
  :bind (:map company-active-map
              ("C-n" . company-select-next)
              ("C-p" . company-select-previous)
              ("M-<" . company-select-first)
              ("M->" . company-select-last))
  :custom
  (company-idle-delay 0.5)
  :config
  (global-company-mode))

(use-package company-lsp
  :after (company lsp)
  :custom
  (company-lsp-cache-candidates t)
  (company-lsp-async t)
  (company-lsp-enable-recompletion t)
  (company-lsp-enable-snippet)
  :config
  (push 'company-lsp company-backends))

(use-package csv-mode
  :mode (("\\.csv\\'" . csv-mode)))

(use-package dap-mode
  :after lsp-mode
  :config
  (dap-mode t)
  (dap-ui-controls-mode)
  (dap-ui-mode t))

(use-package dockerfile-mode
  :mode (("Dockerfile\\'" . dockerfile-mode)))

(use-package eshell
  :no-require t
  :config
  (add-hook 'eshell-mode-hook
            (lambda ()
              (local-set-key (kbd "C-c h")
                             (lambda ()
                               (interactive)
                               (insert (ido-completing-read "Eshell history: "
                                                            (delete-dups
                                                             (ring-elements eshell-history-ring))))))
              (local-set-key (kbd "C-c C-h") 'eshell-list-history))))

(use-package flycheck)

(use-package hl-todo
  :diminish hl-todo
  :custom
  (hl-todo-highlight-punctuation ":")
  (hl-todo-keyword-faces `(("TODO" warning bold)
                           ("FIXME" error bold)
                           ("HACK" font-lock-constant-face bold)
                           ("REVIEW" font-lock-keyword-face bold)
                           ("NOTE" success bold)
                           ("DEPRECATED" font-lock-doc-face bold)))
  (add-hook 'prog-mode-hook #'hl-todo-mode))

(use-package lsp-ivy
  :after (lsp-mode ivy)
  :commands lsp-ivy-workspace-symbol)

(use-package lsp-mode
  :hook ((lsp-mode . lsp-enable-which-key-integration))
  :commands (lsp)
  :custom
  (lsp-auto-guess-root t)
  (lsp-document-sync-method 'incremental)
  (lsp-response-timeout 10)
  (lsp-keymap-prefix "C-c l")
  (lsp-prefer-flymake nil)

  (lsp-print-io t)
  (lsp-trace t)
  (lsp-print-performance t)

  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-rust-analyzer-server-display-inlay-hints t))

(use-package lsp-ui
  :after lsp-mode
  :commands lsp-ui-mode
  :custom
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-delay 0.2)
  (lsp-ui-doc-header t)
  (lsp-ui-doc-include-signature t)
  (lsp-ui-doc-max-height 30)
  (lsp-ui-doc-max-width 120)
  (lsp-ui-doc-position 'at-point)
  (lsp-ui-doc-use-childframe t)
  (lsp-ui-doc-use-webkit nil)
  (lsp-ui-flycheck-enable t)
  (lsp-ui-imenu-enable t)
  (lsp-ui-imenu-kind-position 'top)
  (lsp-ui-peek-enable t)
  (lsp-ui-peek-fontify 'on-demand)
  (lsp-ui-peek-list-width 50)
  (lsp-ui-peek-peek-height 20)
  (lsp-ui-sideline-code-actions-prefix "???" t)
  (lsp-ui-sideline-enable t)
  (lsp-ui-sideline-ignore-duplicate t)
  (lsp-ui-sideline-show-code-actions t)
  (lsp-ui-sideline-show-diagnostics t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-sideline-show-symbol t)
  (lsp-ui-sideline-update-mode 'point)
  (lsp-ui-sideline-delay 0.5)
  ;; FIXME: https://github.com/emacs-lsp/lsp-ui/issues/661
  ;(lsp-ui-sideline-show-hover t)
  :config
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references))

(use-package markdown-mode
  :mode (("\\`README\\.md\\'" . gfm-mode)
         ("\\.mdx?\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)))

(use-package prog-mode
  :preface
  (defun indicate-buffer-boundaries-left ()
    (setq indicate-buffer-boundaries 'left))
  :config
  (global-prettify-symbols-mode t)
  (add-hook 'prog-mode-hook 'indicate-buffer-boundaries-left))

(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook (lambda () (rainbow-delimiters-mode))))

(use-package restclient
  :mode (("\\.rest\\'" . restclient-mode)))

(use-package toml-mode
  :mode "\\.toml\\'")

(use-package yaml-mode
  :mode "\\.ya?ml\\'")

(use-package yasnippet
  :mode (("\\.yasnippet\\'" . snippet-mode))
  :bind (:map yas-minor-mode-map
              ("\C-c TAB" . yas-expand))
  :preface
  (defun company-yasnippet-or-completion ()
    (interactive)
    (or (do-yas-expand)
        (company-complete-common)))
  (defun check-expansion ()
    (save-excursion
      (if (looking-at "\\_>") t
        (backward-char 1)
        (if (looking-at "\\.") t
          (backward-char 1)
          (if (looking-at "::") t nil)))))
  (defun do-yas-expand ()
    (let ((yas/fallback-behavior 'return-nil))
      (yas/expand)))
  (defun tab-indent-or-complete ()
    (interactive)
    (if (minibufferp)
        (minibuffer-complete)
      (if (or (not yas/minor-mode)
              (null (do-yas-expand)))
          (if (check-expansion)
              (company-complete-common)
            (indent-for-tab-command)))))
  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook 'yas-minor-mode)
  (add-hook 'text-mode-hook 'yas-minor-mode))

(provide 'gamma-dev)

;;; gamma-dev.el ends here
