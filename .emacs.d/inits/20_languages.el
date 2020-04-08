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

(use-package counsel-gtags
  :ensure t
  :hook ((c-mode . counsel-gtags-mode)
         (c++-mode . counsel-gtags-mode))
  :bind (:map counsel-gtags-mode-map
              ("M-t" . counsel-gtags-find-definition)
              ("M-r" . counsel-gtags-find-reference)
              ("M-s" . counsel-gtags-find-symbol)
              ("M-," . counsel-gtags-go-backward)))

(add-hook 'eshell-mode-hook
          #'(lambda () (company-mode -1)))
