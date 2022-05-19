;;; apple.el --- Gamma Apple Development configuration

(use-package cc-mode
  :mode (("\\.m\\'" . objc-mode)
         ("\\.mm\\'" . objc-mode))
  :hook ((objc-mode . lsp-deferred))
  :config
  ;; The default mode for .h files is c-mode. This works reasonably way for
  ;; C++ headers, although it has incomplete syntax highlighting, but it's
  ;; much worse for Objective-C, where you get things like parameters not
  ;; lining up properly by their colons. You can handle this by adding a
  ;; function to magic-mode-alist.
  (add-to-list 'magic-mode-alist
               `(,(lambda ()
                    (and (string= (file-name-extension buffer-file-name) "h")
                         (or (re-search-forward
                              "@\\<interface\\>"
                              magic-mode-regexp-match-limit t)
                             (re-search-forward
                              "@\\<protocol>\\>"
                              magic-mode-regexp-match-limit t))))
                 . objc-mode))
  ;; Fix `find-file-other-file'.
  (require 'find-file)
  (nconc (cadr (assoc "\\.h\\'" cc-other-file-alist)) '(".m" ".mm"))

  ;; The bigger problem is that the header-search algorithm doesn't understand
  ;; frameworks. So, <sys/types> properly finds /usr/include/sys/types, but
  ;; <Foundation/Foundation.h> fails.
  (defadvice ff-get-file-name (around ff-get-file-name-framework
                                      (search-dirs
                                       fname-stub
                                       &optional suffix-list))
    "Search for Mac framework headers as well as POSIX headers."
    (or
     (if (string-match "\\(.*?\\)/\\(.*\\)" fname-stub)
         (let* ((framework (match-string 1 fname-stub))
                (header (match-string 2 fname-stub))
                (fname-stub (concat framework ".framework/Headers/" header)))
           ad-do-it))
     ad-do-it))
  (ad-enable-advice 'ff-get-file-name 'around 'ff-get-file-name-framework)
  (ad-activate 'ff-get-file-name)

  (setq cc-search-directories '("."
                                "../include"
                                "/usr/local/include/*"
                                "/System/Library/Frameworks"
                                "/Library/Frameworks")))
(use-package swift-mode
  :mode (("\\.swift\\'" . swift-mode)))

;;; apple.el ends here
