;;; web.el --- Gamma web development configuration

(use-package css-mode :custom (css-indent-offset 2))

(use-package js-mode
  :no-require t
  :hook (js-mode . (lambda () (lsp))))

(use-package json-mode
  :mode "\\.json\\'"
  :preface
  (defun gamma/setup-json-mode ()
    (make-local-variable 'js-indent-level)
    (setq js-indent-level 2))
  :hook (json-mode-hook . gamma/setup-json-mode))

(use-package scss-mode
  :mode "\\.s[ac]ss\\'")

(use-package web-mode
  :disabled
  :mode (("\\.phtml\\'" . web-mode)
         ("\\.tpl\\.php\\'" . web-mode)
         ("\\.[agj]sp\\'" . web-mode)
         ("\\.as[cp]x\\'" . web-mode)
         ("\\.erb\\'" . web-mode)
         ("\\.mustache\\'" . web-mode)
         ("\\.djhtml\\'" . web-mode)
         ("\\.html?\\'" . web-mode)
         ("\\.jsx?\\'" . web-mode)
         ("\\.njk\\'" . web-mode)
         ("\\.nbs\\'" . web-mode)
         ("\\.tsx?\\'" . web-mode))
  :custom
  (web-mode-attr-indent-offset 2)
  (web-mode-attr-value-indent-offset 2)
  (web-mode-code-indent-offset 2)
  (web-mode-css-indent-offset 2)
  (web-mode-enable-auto-quoting nil)
  (web-mode-markup-indent-offset 2))

;;; web.el ends here
