;;; idl.el --- Gamma IDLs

(use-package protobuf-mode
  :mode "\\.proto\\'")

;;; LICENSE for thrift-mode:
;;
;; Licensed to the Apache Software Foundation (ASF) under one
;; or more contributor license agreements. See the NOTICE file
;; distributed with this work for additional information
;; regarding copyright ownership. The ASF licenses this file
;; to you under the Apache License, Version 2.0 (the
;; "License"); you may not use this file except in compliance
;; with the License. You may obtain a copy of the License at
;;
;;   http://www.apache.org/licenses/LICENSE-2.0
;;
;; Unless required by applicable law or agreed to in writing,
;; software distributed under the License is distributed on an
;; "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
;; KIND, either express or implied. See the License for the
;; specific language governing permissions and limitations
;; under the License.
;;

(require 'font-lock)

(defvar thrift-mode-hook nil)
(add-to-list 'auto-mode-alist '("\\.thrift\\'" . thrift-mode))

(defvar thrift-indent-level 2
  "Defines 2 spaces for thrift indentation.")

;; syntax coloring
(defconst thrift-font-lock-keywords
  (list
   '("#.*$" . font-lock-comment-face)  ;; perl style comments
   '("\\<\\(include\\|struct\\|exception\\|typedef\\|const\\|enum\\|service\\|extends\\|void\\|oneway\\|throws\\|optional\\|required\\)\\>" . font-lock-keyword-face)  ;; keywords
   '("\\<\\(bool\\|byte\\|i16\\|i32\\|i64\\|double\\|string\\|binary\\|map\\|list\\|set\\)\\>" . font-lock-type-face)  ;; built-in types
   '("\\<\\([0-9]+\\)\\>" . font-lock-variable-name-face)   ;; ordinals
   '("\\<\\(\\w+\\)\\s-*(" (1 font-lock-function-name-face))  ;; functions
   )
  "Thrift Keywords")

;; indentation
(defun thrift-indent-line ()
  "Indent current line as Thrift code."
  (interactive)
  (beginning-of-line)
  (if (bobp)
      (indent-line-to 0)
    (let ((not-indented t) cur-indent)
      (if (looking-at "^[ \t]*\\(}\\|throws\\)")
          (if (looking-at "^[ \t]*}")
              (progn
                (save-excursion
                  (forward-line -1)
                  (setq cur-indent (- (current-indentation) thrift-indent-level)))
                (if (< cur-indent 0)
                    (setq cur-indent 0)))
            (progn
              (save-excursion
                (forward-line -1)
                (if (looking-at "^[ \t]*[\\.<>[:word:]]+[ \t]+[\\.<>[:word:]]+[ \t]*(")
                    (setq cur-indent (+ (current-indentation) thrift-indent-level))
                  (setq cur-indent (current-indentation))))))
        (save-excursion
          (while not-indented
            (forward-line -1)
            (if (looking-at "^[ \t]*}")
                (progn
                  (setq cur-indent (current-indentation))
                  (setq not-indented nil))
              (if (looking-at "^.*{[^}]*$")
                  (progn
                    (setq cur-indent (+ (current-indentation) thrift-indent-level))
                    (setq not-indented nil))
                (if (bobp)
                    (setq not-indented nil)))
              (if (looking-at "^[ \t]*throws")
                  (progn
                    (setq cur-indent (- (current-indentation) thrift-indent-level))
                    (if (< cur-indent 0)
                        (setq cur-indent 0))
                    (setq not-indented nil))
                (if (bobp)
                    (setq not-indented nil)))
              (if (looking-at "^[ \t]*[\\.<>[:word:]]+[ \t]+[\\.<>[:word:]]+[ \t]*([^)]*$")
                  (progn
                    (setq cur-indent (+ (current-indentation) thrift-indent-level))
                    (setq not-indented nil))
                (if (bobp)
                    (setq not-indented nil)))
              (if (looking-at "^[ \t]*\\/\\*")
                  (progn
                    (setq cur-indent (+ (current-indentation) 1))
                    (setq not-indented nil))
                (if (bobp)
                    (setq not-indented nil)))
              (if (looking-at "^[ \t]*\\*\\/")
                  (progn
                    (setq cur-indent (- (current-indentation) 1))
                    (setq not-indented nil))
                (if (bobp)
                    (setq not-indented nil)))
              ))))
      (if cur-indent
          (indent-line-to cur-indent)
        (indent-line-to 0)))))

;; C/C++ comments; also allowing underscore in words
(defvar thrift-mode-syntax-table
  (let ((thrift-mode-syntax-table (make-syntax-table)))
    (modify-syntax-entry ?_ "w" thrift-mode-syntax-table)
    (modify-syntax-entry ?/ ". 1456" thrift-mode-syntax-table)
    (modify-syntax-entry ?* ". 23" thrift-mode-syntax-table)
    (modify-syntax-entry ?\n "> b" thrift-mode-syntax-table)
    thrift-mode-syntax-table)
  "Syntax table for thrift-mode")

(defun thrift-mode ()
  "Mode for editing Thrift files"
  (interactive)
  (kill-all-local-variables)
  (set-syntax-table thrift-mode-syntax-table)
  (set (make-local-variable 'font-lock-defaults) '(thrift-font-lock-keywords))
  (setq major-mode 'thrift-mode)
  (setq mode-name "Thrift")
  (run-hooks 'thrift-mode-hook)
  (set (make-local-variable 'indent-line-function) 'thrift-indent-line)
  )

;;; idl.el ends here
