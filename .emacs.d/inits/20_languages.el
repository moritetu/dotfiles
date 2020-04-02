(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :hook (go-mode . lsp-deferred))

(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

(use-package company
  :ensure t
  :config
  (global-company-mode)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1)
  (setq company-selection-wrap-around t))

(use-package company-lsp
  :ensure t
  :commands company-lsp)


;; Golang
;; See https://github.com/golang/tools/blob/master/gopls/doc/emacs.md
(use-package go-mode
  :ensure t
  :mode (("\\.go\\'" . go-mode))
  :config
  (setq indent-tabs-mode nil)
  (setq c-basic-offset 4)
  (setq tab-width 4))


;; shell
(add-hook 'sh-mode-hook (lambda ()
                          (setq indent-tabs-mode nil
                                sh-basic-offset 2
                                sh-indentation 2)))
