;;; elixir.el --- Gamma Elixir configuration

(use-package elixir-mode
  :mode (("\\.exs?\\'" . elixir-mode))
  :hook (elixir-mode . (lambda () (lsp))))

;;; elixir.el ends here
