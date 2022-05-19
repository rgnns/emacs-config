;;; gamma-vc.el --- Gamma Version Control

(use-package diff-hl
  :custom
  (diff-hl-draw-borders nil)
  :config
  (global-diff-hl-mode)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh t))

(use-package gitconfig-mode
  :mode ("/\\.gitconfig\\'"
         "/\\.git/config\\'"
         "/modules/.*/config\\'"
         "/git/config\\'"
         "/\\.gitmodules\\'"
         "/etc/gitconfig\\'"))

(use-package gitignore-mode
  :mode ("/\\.gitignore\\'"
         "gitignore_global\\'"
         "/info/exclude\\'"
         "/git/ignore\\'"))

(use-package git-timemachine
  :commands git-timemachine)

(use-package git-undo
  :commands git-undo)
             
(use-package magit
  :bind (("C-c m" . magit-status))
  :custom
  (magit-bury-buffer-function 'magit-mode-quit-window)
  (magit-commit-extend-override-date nil)
  (magit-commit-reword-override-date nil)
  (magit-commit-squash-confirm nil)
  (magit-log-arguments '("--graph" "--color" "--decorate" "-n128"))
  (magit-remote-set-if-missing 'default)
  (magit-save-repository-buffers 'dontask)
  (magit-section-initial-visibility-alist '((unpushed . show)
                                            (unpulled . show)))
  (magit-show-refs-arguments '("--merged=main"))
  (magit-transient-default-level 5)
  :config
  (magit-add-section-hook 'magit-status-sections-hook
                          'magit-insert-modules
                          'magit-insert-stashes
                          'append))

(provide 'gamma-vc)

;;; gamma-vc.el ends here
