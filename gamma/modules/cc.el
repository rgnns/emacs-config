;;; cc.el --- Gamma C/C++ configuration

(use-package google-c-style
  :defines c-basic-offset
  :hook (((c-mode c++-mode) . google-set-c-style)
         (c-mode-common . google-make-newline-indent)
         (objc-mode . (lambda ()
                        (google-set-c-style)
                        (setq c-basic-offset 2)))))

;;; cc.el ends here
