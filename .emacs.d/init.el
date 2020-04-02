;;;; Basic settings
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file)

(when (string= system-type "darwin")
  (setq dired-use-ls-dired nil))

;;;; Plugin management
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(setq
 ;; use-package does this
 package-enable-at-startup nil
 package-archives
 '(("melpa" . "https://melpa.org/packages/")
   ("gnu" . "https://elpa.gnu.org/packages/")
;   ("melpa-stable" . "https://stable.melpa.org/packages/")
;   ("org" . "https://orgmode.org/elpa/")

   ))

(require 'package)
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(setq use-package-enable-imenu-support t)
(setq use-package-verbose t)
(eval-when-compile (require 'use-package))
(require 'bind-key)


;;;; loads configuration via init-loader
(use-package init-loader
  :ensure t
  :config
  (init-loader-load (locate-user-emacs-file "inits")))
