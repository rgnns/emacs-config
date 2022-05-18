;;; init.el --- Emacs initialization  -*- lexical-binding: t -*-
;;;
;;; Commentary:
;;; Starting point for Emacs initialization. Before this only early-init.el.
;;;
;;; Code:

;; (package-initialize)

(setq user-full-name "Gabriel Lievano"
      user-mail-address "emacs-gamma@gabriellievano.com")

;; Initialize Borg instead of Package
(when (< emacs-major-version 27)
  (setq package-enable-at-startup nil))
(add-to-list 'load-path (expand-file-name "lib/borg" user-emacs-directory))
(require 'borg)
(borg-initialize)

;; Local Variables:
;; indent-tabs-mode: nil
;; End:
;;; init.el ends here
