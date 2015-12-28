;; Alexander Ross emacs settings

;; Set backup dir
(setq backup-directory-alist '((".*" . "~/.Trash/emacs_backup")))

;; Hide menu
(menu-bar-mode -1)

;; Default indentation
(add-hook 'php-mode-hook 'my-php-mode-hook)
(defun my-php-mode-hook ()
  "My PHP mode configuration."
  (setq indent-tabs-mode nil
        tab-width 2
        c-basic-offset 2))

;; Hide Tool Bar if it exists
(if (functionp 'tool-bar-mode)
    (tool-bar-mode -1))

;; Move between windows with ESC + arrow
(global-set-key (kbd "ESC <left>")  'windmove-left)
(global-set-key (kbd "ESC <right>") 'windmove-right)
(global-set-key (kbd "ESC <up>")    'windmove-up)
(global-set-key (kbd "ESC <down>")  'windmove-down)

;; Ctags and auto complete
;; apt-get install exuberant-ctags
(setq projectile-tags-command "ctags -Re --exclude=db --exclude=test --exclude=.git --exclude=log --exclude=public -f \"%s\" %s")
;; (add-hook 'after-init-hook 'global-company-mode)

;; Display tooltips
(tooltip-mode -1)
;; (setq tooltip-use-echo-area t)

;; Stop prompting every time I open a gemspec
(setq safe-local-variable-values
      (append '((encoding . utf-8)) safe-local-variable-values))

;; Disable prompts
(fset 'yes-or-no-p 'y-or-n-p)
(setq confirm-nonexistent-file-or-buffer nil)

;; Moving to last line inserts newline
(setq next-line-add-newlines t)
(setq require-final-newline 't)
(setq mode-require-final-newline 't)

;; Font
(set-frame-font "Source Code Pro:pixelsize=14")

;; Remove trailing space on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Emacs is not a package manager, and here we load its package manager!
(require 'package)
(dolist (source '(("marmalade" . "http://marmalade-repo.org/packages/")
                  ("elpa" . "http://tromey.com/elpa/")
                  ("melpa" . "http://melpa.milkbox.net/packages/")
                  ))
  (add-to-list 'package-archives source t))
(package-initialize)


;; Required packages
;; everytime emacs starts, it will automatically check if those packages are
;; missing, it will install them automatically
(when (not package-archive-contents)
  (package-refresh-contents))
(defvar tmtxt/packages
  '(web-mode magit
             ruby-mode
             company
             multiple-cursors
             expand-region
             flycheck
             markdown-mode
             yaml-mode
             helm
             helm-dash
             helm-ag
             projectile
             helm-projectile
             editorconfig
             gist
             ))
(dolist (p tmtxt/packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; Editor config
(editorconfig-mode 1)

;; Helm
(require 'helm-config)
(helm-mode 1)

;; Flycheck - syntax checking
;; (add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'ruby-mode-hook 'flycheck-mode)

;; Projectile
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(global-set-key (kbd "C-x f") 'helm-projectile-find-file)
;; Selection
(require 'expand-region)
(global-set-key (kbd "C-x 9") 'er/expand-region)


;; Markdown
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; Yaml
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; Theme
(load-theme 'wombat t)


;; Autosaving - I don't care about that
(setq auto-save-default nil)

;; Show line numbers when loading files
(global-linum-mode 1)
(add-hook 'eshell-mode-hook (lambda () (linum-mode -1)))
(setq linum-format " %5d  ")
(set-face-attribute 'linum nil :background "#222")
(set-face-attribute 'linum nil :foreground "#666")
(setq-default left-fringe-width  10)
(setq-default right-fringe-width  0)

;; Multiple cursors
(global-set-key (kbd "C-c <") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c >") 'mc/mark-all-like-this)

;; Ruby
(add-to-list 'auto-mode-alist
             '("\\.\\(?:gemspec\\|irbrc\\|gemrc\\|rake\\|rb\\|ru\\|thor\\)\\'" . ruby-mode))
(add-to-list 'auto-mode-alist
             '("\\(Capfile\\|Gemfile\\(?:\\.[a-zA-Z0-9._-]+\\)?\\|[rR]akefile\\)\\'" . ruby-mode))

;; Ruby - dash
(add-hook 'ruby-mode-hook '(lambda ()
                             (company-mode) ;; use autocompletion
                             (setq-local helm-dash-docsets '("Ruby on Rails" "Ruby"))
                             (setq helm-current-buffer (current-buffer))))

;; Tabs
;; Most of this should be taken care of by .editorconfig, but
;; I have added some defaults here
(setq-default indent-tabs-mode nil)
(setq tab-width 2) ; or any other preferred value
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

;; Magit shortcut
(global-set-key (kbd "C-x g") 'magit-status)

;; PHP
(add-to-list 'auto-mode-alist '("\\.php$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.scss\\'" . web-mode))
