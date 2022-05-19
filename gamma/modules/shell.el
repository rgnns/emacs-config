;;; shell.el --- Gamma SHell configuration

(use-package shfmt
  :hook (sh-mode . shfmt-on-save-mode))

(use-package fish-mode
  :custom
  (fish-indent-offset 2))

(use-package flymake-shellcheck
  :commands flymake-shellcheck-load
  :init
  (add-hook 'sh-mode-hook 'flymake-shellcheck-load))

;;; shell.el ends here
