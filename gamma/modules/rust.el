;;; rust.el --- Gamma Rust configuration

(use-package rustic
  :bind (:map rustic-mode-map
              ("M-j" . lsp-ui-imenu)
              ("M-?" . lsp-find-references)
              ("C-c C-c l" . flycheck-list-errors)
              ("C-c C-c a" . lsp-execute-code-action)
              ("C-c C-c r" . lsp-rename)
              ("C-c C-c q" . lsp-workspace-restart)
              ("C-c C-c Q" . lsp-workspace-shutdown)
              ("C-c C-c s" . lsp-rust-analyzer-status))
  :preface
  (defun gamma/rustic-mode-hook ()
    (setq rustic-indent-offset 2))
  :custom
  (rustic-format-on-save t)
  (rustic-lsp-client 'lsp-mode)
  (rustic-lsp-server 'rust-analyzer)
  :config
  (add-hook 'rustic-mode-hook 'gamma/rustic-mode-hook))

;;; rust.el ends here
