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

(use-package swiper
  :diminish ivy-mode
  :bind (("C-s" . swiper)))

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
  (set-face-attribute 'which-key-local-map-description-face nil :height 'bold)
  (which-key-setup-side-window-bottom))

(provide 'gamma-ux)

;;; gamma-ux.el ends here
