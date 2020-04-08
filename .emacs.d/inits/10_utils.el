;; https://qiita.com/itiut@github/items/d917eafd6ab255629346
(defmacro with-suppressed-message (&rest body)
  "Suppress new messages temporarily in the echo area and the `*Messages*' buffer while BODY is evaluated."
  (declare (indent 0))
  (let ((message-log-max nil))
    `(with-temp-message (or (current-message) "") ,@body)))

(use-package recentf
  :config
  (setq ecentf-max-saved-items 1000)
  (setq recentf-exclude '(".recentf" "/TAGS$" "/var/tmp"))
  (setq recentf-keep '(file-remote-p file-readable-p))
  (setq recentf-auto-save-timer (run-with-idle-timer 30 t #'(lambda ()
							      (with-suppressed-message (recentf-save-list)))))
  (setq recentf-auto-cleanup 'never)
  (recentf-mode 1))

(use-package init-open-recentf
  :ensure t
  :config
  (init-open-recentf))

(use-package recentf-ext
  :ensure t)

(use-package dired
  :ensure nil
  :bind (:map dired-mode-map
	      ("r" . wdired-change-to-wdired-mode))
  :config
  (setq wdired-allow-to-change-permissions t))

(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :ensure t
  :config
  (exec-path-from-shell-initialize))

(use-package ag
  :ensure t
  :bind (:map ag-mode-map
	      ("r" . wgrep-change-to-wgrep-mode))
  :hook (ag-mode . wgrep-ag-setup)
  :config
  (setq ag-highlight-search t)
  (setq ag-reuse-buffers t))

(use-package wgrep-ag
  :ensure t
  :commands (wgrep-ag-setup)
  :config
  (setq wgrep-auto-save-buffer t)
  (setq wgrep-change-readonly-file t))

(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode 1))

(use-package migemo
  :ensure t
  :config
  (setq migemo-command "/usr/local/bin/cmigemo")
  (setq migemo-options '("-q" "--emacs"))
  (setq migemo-coding-system 'utf-8-unix)
  (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (load-library "migemo")
  (migemo-init))
