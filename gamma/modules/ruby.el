;;; ruby.el --- Gamma Ruby configuration

(use-package ruby-mode
  :mode (("\\.rake\\'" . ruby-mode)
         ("\\.gemspec\\'" . ruby-mode)
         ("\\.ru\\'" . ruby-mode)
         ("(Release)?Fastmail\\'" . ruby-mode)
         ("(App|Cap|Cart|Fast|Gem|Guard|Match|Pod|Rake)file\\'" . ruby-mode)
         ("Vagrantfile(.local)\\'" . ruby-mode)))

;;; ruby.el ends here
