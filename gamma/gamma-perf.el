;;; gamma-perf.el --- Gamma performance.

(defvar gamma--before-user-init-time (current-time)
  "Value of `current-time' when Emacs begin loading `user-init-file'.")

(message "Loading Emacs... done (%.3fs)"
	 (float-time (time-subtract gamma--before-user-init-time
				    before-init-time)))

(add-hook 'after-init-hook
	  `(lambda ()
	     (let ((elapsed
		    (float-time
		     (time-subtract (current-time) gamma--before-user-init-time))))
	       (message "Loading %s... done (%.3fs)"
			,load-file-name elapsed))) t)

(defvar gamma--gc-cons-threshold 16777216)
(defun gamma/defer-gc-h ()
  (setq gc-cons-threshold most-positive-fixnum))
(defun gamma/restore-gc-h ()
  (run-at-time
   1 nil (lambda ()
	   (setq gc-cons-threshold gamma--gc-cons-threshold))))
(add-hook 'minibuffer-setup-hook #'gamma/defer-gc-h)
(add-hook 'minibuffer-exit-hook #'gamma/restore-gc-h)

(defvar gamma--last-file-name-handler-alist file-name-handler-alist)

(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6
      file-name-handler-alist nil
      message-log-max 16384)

(add-hook 'emacs-startup-hook
	  (lambda ()
	    (setq gc-cons-threshold gamma--gc-cons-threshold
		  gc-cons-percentage 0.1
		  file-name-handler-alist gamma--last-file-name-handler-alist)))

(setq message-log-max 16384)

(provide 'gamma-perf)

;;; end of gamma-perf.el
