;;; early-init.el --- Early bird  -*- no-byte-compile: t -*-

(setq load-prefer-newer t
      package-enable-at-startup nil)

;(let ((dir (file-name-directory (or load-file-name buffer-file-name))))
;  (add-to-list 'load-path (expand-file-name "lib/packed" dir))
;  (add-to-list 'load-path (expand-file-name "lib/auto-compile" dir)))
;(require 'auto-compile)
;(auto-compile-on-load-mode)
;(auto-compile-on-save-mode)

(with-eval-after-load 'package
  (add-to-list 'package-archives
               (cons "melpa" "https://melpa.org/packages/")
               t)
  (add-to-list 'package-archives
               (cons "org" "https://orgmode.org/elpa/")
               t))

(push '(tool-bar-lines . 0) default-frame-alist)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(inhibit-double-buffering . t) default-frame-alist)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: t
;; End:
;;; early-init.el ends here
