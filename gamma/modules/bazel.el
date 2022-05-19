;;; bazel.el --- Gamma Bazel configuration

(use-package bazel
  :hook ((bazel-mode . (lambda ()
                         (add-hook 'before-save-hook #'bazel-mode-buildifier nil t)))))

;;; bazel.el ends here
