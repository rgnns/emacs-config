;;; gamma-ux.el --- Gamma UX

(use-package ace-window
  :bind ("<C-return>" . ace-window)
  :custom
  (aw-dispatch-always t)
  (aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))

(use-package avy
  :bind ("C-." . avy-goto-char-timer)
  :custom
  (avy-background t)
  (avy-style 'at-full)
  (avy-timeout-seconds 0.2)
  :config
  (avy-setup-default))

(use-package counsel
  :diminish
  :custom
  (counsel-async-filter-update-time 40000)
  (counsel-git-cmd "rg -S --files")
  (counsel-grep-base-command
   "rg -S -M 240 --no-heading --line-number --color never %s %s")
  (counsel-switch-buffer-preview-virtual-buffers nil)
  :config
  (counsel-mode 1))

(use-package counsel-projectile
  :after (counsel projectile)
  :functions counsel-projectile-modify-action
  :config
  (counsel-projectile-modify-action
   'counsel-projectile-switch-project-action
   '((move counsel-projectile-switch-project-action-dired 1)))
  (counsel-projectile-mode))

(use-package flx
  :after ivy
  :defer t
  :custom (ivy-flx-limit 10000))

(use-package ivy
  :diminish
  :bind (("C-c C-r" . ivy-resume)
         :map ivy-minibuffer-map
         ("C-y" . ivy-next-line)
         ("C-d" . gamma/ivy-done-or-delete-char))
  :preface
  (defun gamma/ivy-done-or-delete-char ()
    (interactive)
    (call-interactively
     (if (eolp)
         #'ivy-immediate-done
       #'ivy-delete-char)))
  :custom
  (ivy-dynamic-exhibit-delay-ms 200)
  (ivy-height 10)
  (ivy-initial-inputs-alist nil t)
  (ivy-magic-tilde nil)
  (ivy-re-builders-alist '((t . ivy--regex-ignore-order)))
  (ivy-use-virtual-buffers t)
  (ivy-wrap t)
  :config
  (ivy-mode 1))

(use-package projectile
  :diminish
  :bind-keymap ("C-c p" . projectile-command-map)
  :init
  (put 'projectile-project-root 'safe-local-variable 'stringp)
  (setq-default projectile-mode-line-prefix "")
  :preface
  (defun gamma/projectile-invalidate-cache (^rest _args)
    (projectile-invalidate-cache nil))
  :custom
  (projectile-enable-caching t)
  (projectile-indexing-method 'alien)
  :config
  (projectile-mode)
  (eval-after-load 'magit-branch
    `(progn
       (advice-add 'magit-checkout
                   :after #'gamma/projectile-invalidate-cache)
       (advice-add 'magit-branch-and-checkout
                   :after #'gamma/projectile-invalidate-cache))))

(use-package swiper
  :diminish ivy-mode
  :bind (("C-s" . swiper)))

(use-package undo-tree
  :init
  (global-undo-tree-mode)
  :custom
  (undo-tree-visualizer-diff t)
  (undo-tree-visualizer-timestamps t))

(use-package which-key
  :custom
  (which-key-add-column-padding 1)
  (which-key-max-displays-columns nil)
  (which-key-min-displays-lines 5)
  (which-key-idle-delay 0.3)
  (which-key-sort-order #'which-key-prefix-then-key-order)
  (which-key-sort-uppercase-first nil)
  :config
  (which-key-mode)
  (set-face-attribute 'which-key-local-map-description-face nil :weight 'bold)
  (which-key-setup-side-window-bottom))

(provide 'gamma-ux)

;;; gamma-ux.el ends here
