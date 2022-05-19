;;; init.el --- Emacs initialization  -*- lexical-binding: t -*-
;;;
;;; Commentary:
;;; Starting point for Emacs initialization. Before this only early-init.el.
;;;
;;; Code:

;; (package-initialize)

(setq user-full-name "Gabriel Lievano"
      user-mail-address "emacs-gamma@gabriellievano.com")

(add-to-list 'load-path (expand-file-name "gamma" user-emacs-directory))
(require 'gamma)

(gamma/load!
 bazel
 elixir
 haskell
 python
 shell
 ruby
 rust
 swift
 web)

;; Local Variables:
;; indent-tabs-mode: nil
;; End:
;;; init.el ends here
