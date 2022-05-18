;;; gamma-borg.el --- Borg configuration

;; Initialize Borg instead of Package
(eval-and-compile ; borg
  (add-to-list 'load-path (expand-file-name "lib/borg" user-emacs-directory))
  (require 'borg)
  (borg-initialize))

(require 'gamma-pkgs)

;(use-package dash)
;(use-package eieio)

(use-package auto-compile
  :custom
  (auto-compile-display-buffer nil)
  (auto-compile-mode-line-counter t)
  (auto-compile-source-recreate-deletes-dest t)
  (auto-compile-toggle-deletes-nonlib-dest t)
  (auto-compile-udpate-autoloads t))

(use-package epkg
  :defer t
  :init (setq epkg-respository
              (expand-file-name "var/epkgs/" user-emacs-directory)))

(provide 'gamma-borg)

;;; gamma-borg.el ends here
