;;; gamma-utils.el --- Gamma Utils

(defmacro gamma/load! (&rest modules)
  "Bootstrap Gamma optional modules."
  (dolist (module modules)
    (load (expand-file-name (format "gamma/modules/%s.el" module)
                          user-emacs-directory))))

(provide 'gamma-utils)

;;; gamma-utils.el ends here
