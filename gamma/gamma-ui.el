;;; gamma-ui.el --- Gamma UI

(defun gamma/switch-theme (theme)
  "Disable active themes and load THEME."
  (interactive (list (intern (completing-read "Theme: "
                                              (->> (custom-available-themes)
                                                   (-map #'symbol-name))))))
  (load-theme theme t))

(if (boundp 'scroll-bar-mode) (scroll-bar-mode -1))

(set-face-attribute 'default nil
                    :family "Iosevka Term SS15"
                    :weight 'normal
                    :height 130)

(use-package all-the-icons-ivy
  :hook (after-init . all-the-icons-ivy-setup)
  :custom
  (all-the-icons-ivy-buffer-commands '())
  (all-the-icons-ivy-file-commands '(counsel-find-file
                                     counsel-file-jump
                                     counsel-recentf
                                     counsel-projectile-find-file
                                     counsel-projectile-find-dir)))

(use-package all-the-icons-ivy-rich
  :init (all-the-icons-ivy-rich-mode 1))

(use-package doom-themes
  :config (gamma/switch-theme 'doom-one-light))

(use-package emojify
  :config
  (setq emojify-styles (delq nil (list 'ascii 'github 'unicode)))
  (emojify-set-emoji-styles emojify-styles)
  (global-emojify-mode))

(use-package ivy-rich
  :after ivy
  :custom
  (ivy-virtual-abbreviate 'full)
  (ivy-rich-switch-buffer-align-virtual-buffer t)
  (ivy-rich-path-style 'abbrev)
  :config
  (ivy-rich-mode 1)
  (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line))

(use-package moody
  :unless noninteractive
  :defer 1
  :custom
  (moody-mode-line-height 20)
  :config
  (declare-function moody-replace-vc-mode "moody" ())
  (declare-function moody-replace-mode-line-buffer-identification "moody" ())
  (setq x-underline-at-descent-line t)
  (moody-replace-mode-line-buffer-identification)
  (moody-rpelace-vc-mode))

(provide 'gamma-ui)

;;; gamma-ui.el ends here
