;;; haskell.el --- Gamma Haskell configuration

(use-package flycheck-haskell
  :commands flycheck-haskell-setup)

(use-package haskell-mode
  :mode (("\\.hs\\(c\\|-bot\\)?\\'" . haskell-mode)
         ("\\.lhs\\'" . literate-haskell-mode)
         ("\\.cabal\\'" . haskell-cabal-mode))
  :preface
  (defvar haskell-prettify-symbols-alist
    '(("::"     . ?∷)
      ("forall" . ?∀)
      ("exists" . ?∃)
      ("->"     . ?→)
      ("<-"     . ?←)
      ("=>"     . ?⇒)
      ("~>"     . ?⇝)
      ("<~"     . ?⇜)
      ("<>"     . ?⨂)
      ("msum"   . ?⨁)
      ("\\"     . ?λ)
      ("not"    . ?¬)
      ("&&"     . ?∧)
      ("||"     . ?∨)
      ("/="     . ?≠)
      ("<="     . ?≤)
      (">="     . ?≥)
      ("<<<"    . ?⋘)
      (">>>"    . ?⋙)
      ("`elem`"             . ?∈)
      ("`notElem`"          . ?∉)
      ("`member`"           . ?∈)
      ("`notMember`"        . ?∉)
      ("`union`"            . ?∪)
      ("`intersection`"     . ?∩)
      ("`isSubsetOf`"       . ?⊆)
      ("`isNotSubsetOf`"    . ?⊄)
      ("`isSubsequenceOf`"  . ?⊆)
      ("`isProperSubsetOf`" . ?⊂)
      ("undefined"          . ?⊥)))
  :config
  (defun gamma/haskell-mode-setup ()
    (haskell-indentation-mode)
    (interactive-haskell-mode)
    (diminish 'interactive-haskell-mode)
    (flycheck-mode 1)
    (flycheck-haskell-setup)
    (setq-local prettify-symbols-alist haskell-prettify-symbols-alist)
    (prettify-symbols-mode 1)
    (bug-reference-prog-mode 1))
  (add-hook 'haskell-mode-hook #'gamma/haskell-mode-hook ()))

;;; haskell.el ends here
