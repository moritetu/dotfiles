(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)
(set-file-name-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)

(setq scroll-step 1)

(column-number-mode t)
(line-number-mode t)
(size-indication-mode t)

(setq blink-cursor-interval 0.5
      blink-cursor-delay 1.0)
(blink-cursor-mode 1)

(setq inhibit-startup-message t)
(tool-bar-mode -1)

(setq eol-mnemonic-dos "(CRLF)"
      eol-mnemonic-mac "(CR)"
      eol-mnemonic-unix "(LF)")

(setq show-paren-delay 0)
(show-paren-mode t)

(global-auto-revert-mode 1)

;; Shortcut of yes or no
(fset 'yes-or-no-p 'y-or-n-p)

(setq completion-ignore-case t
      read-file-name-completion-ignore-case t)

;; Don't use tab but space
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; Add a newline at end of file
(setq require-final-newline t)

;; Backup files
(setq create-lockfiles nil)
(setq make-backup-files t)
(let* ((backup-directory (locate-user-emacs-file "backups")))
  (dolist (dir (list backup-directory))
    (when (not (file-directory-p dir))
      (make-directory dir t)))
  (setq backup-directory-alist `(("." . ,backup-directory))
	auto-save-file-name-transforms `((".*" ,backup-directory t))))


(add-hook 'before-save-hook 'delete-trailing-whitespace)


;; Enable wind move
(setq windmove-wrap-around t)
(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <down>")  'windmove-down)

(global-set-key (kbd "C-x ?") 'help-command)
(global-set-key (kbd "C-h") 'backward-delete-char)
