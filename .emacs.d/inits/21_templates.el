(use-package autoinsert
  :hook (find-file . auto-insert)
  :config
  (setq auto-insert-directory (locate-user-emacs-file "templates"))
  ;; Add some templates
  (define-auto-insert '("\\.go\\'" . "Go template") "template.go"))

;; http://joaotavora.github.io/yasnippet/
(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode
  :config
  (yas-global-mode t))

(use-package yasnippet-snippets :ensure t)
