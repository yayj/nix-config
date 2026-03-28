;; Global Settings

(setopt inhibit-startup-screen t
        make-backup-files nil
        cursor-type 'hbar)

;; Set tab size to 2 for all mode
(setopt indent-tabs-mode nil
        tab-width 2
        standard-indent 2
        treesit-simple-indent-offset 2
        c-basic-offset 2
        c-ts-mode-indent-offset 2
        js-indent-level 2
        lua-ts-indent-offset 2
        perl-indent-level 2
        python-ts-indent-offset 2
        sh-basic-offset 2
        tcl-indent-level 2
        typescript-indent-level 2)

;; UI adjustment
(defun apply-ui-settings (frame)
  "Apply setting for each frames."
  (select-frame frame)
  (if (display-graphic-p frame)
      (progn
        (menu-bar-mode 1)
        (tool-bar-mode -1)
        (scroll-bar-mode -1)
        (set-fringe-mode 10)
        (set-frame-font "FiraCode Nerd Font-12" nil t)
        (set-frame-parameter frame 'width 100)
        (set-frame-parameter frame 'height 50)
        (setopt frame-title-format "Emacs GUI - %b"))
    (progn
      (menu-bar-mode -1)
      (setopt frame-title-format "Emacs TTY - %b"))))
(apply-ui-settings (selected-frame))
(add-hook 'after-make-frame-functions #'apply-ui-settings)

(column-number-mode 1)
(global-auto-revert-mode 1)

;; Put customize settings to a separated file
(setopt custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; Initialize straight.el as the package manager
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setopt straight-use-package-by-default t)

;; Packages

;; Ace window (https://github.com/abo-abo/ace-window)
(use-package ace-window
  :init
  (setopt aw-dispatch-always t)
  :bind
  ("M-o" . #'ace-window))

;; Aggressive indent mode (https://github.com/Malabarba/aggressive-indent-mode)
(use-package aggressive-indent
  :config
  (global-aggressive-indent-mode t))

;; Command log mode (https://github.com/lewang/command-log-mode)
(use-package command-log-mode
  :config
  (global-command-log-mode t))

;; Counsel (https://github.com/abo-abo/swiper)
(use-package counsel
  :after ivy
  :bind (("M-x" . #'counsel-M-x)
	       ("C-x C-f" . #'counsel-find-file)
	       ("C-c j" . #'counsel-git-grep)
	       (:map minibuffer-local-map
	             ("C-r" . #'counsel-minibuffer-history))))

;; Doom modeline (https://seagle0128.github.io/doom-modeline/)
(use-package doom-modeline
  :after
  nerd-icons
  :init
  (setopt
   nerd-icons-font-family "FiraCode Nerd Font"
   doom-modeline-major-mode-icon t
   doom-modeline-major-mode-color-icon t
   doom-modeline-unicode-fallback nil)
  :config
  (doom-modeline-mode 1))

(use-package format-all
  :commands format-all-mode
  :hook ((json-ts-mode nix-mode yaml-ts-mode) . format-all-mode)
  :config
  (setq format-all-formatters
        '(("CMake" cmake-format)
          ("JSON" prettier)
          ("Nix" alejandra)
          ("YAML" prettier))))

;; General (https://github.com/noctuid/general.el)
;; (use-package general)

;; Ivy (https://github.com/abo-abo/swiper)
(use-package ivy
  :init
  (setopt
   ivy-use-virtual-buffers t
   enable-recursive-minibuffers t)
  :bind
  ("C-c C-r" . #'ivy-resume)
  :config
  (ivy-mode 1))

;; Ivy rich (https://github.com/Yevgnen/ivy-rich)
(use-package ivy-rich
  :after ivy
  :config (ivy-rich-mode 1))

(use-package just-mode
  :init (setopt just-indent-offset 2))

;; Magit (https://magit.vc/)
(use-package magit)

(use-package nerd-icons)

;; Nix mode (https://github.com/NixOS/nix-mode)
(use-package nix-mode)

;; Projectile (https://github.com/bbatsov/projectile)
(use-package projectile
  :bind (:map projectile-mode-map
              ("s-p" . projectile-command-map)
              ("C-c p" . projectile-command-map))
  :init
  (projectile-mode +1))

;; Solarized themes (https://github.com/bbatsov/solarized-emacs)
(use-package solarized-theme
  :config
  (load-theme 'solarized-selenized-light t))

;; Swiper (https://github.com/abo-abo/swiper)
(use-package swiper
  :after ivy
  :bind ("C-s" . #'swiper-isearch))

;; Add mode toggle key for terminal mode
(use-package term)
(define-key term-raw-map (kbd "M-q") 'term-line-mode)
(define-key term-mode-map (kbd "M-q") 'term-char-mode)

;; Automatically install and use tree-sitter major modes in Emacs 29+. (https://github.com/renzmann/treesit-auto)
(use-package treesit-auto
  :custom
  (treesit-auto-install 't)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode)
  :hook
  ;; Disable the indentations generated due to namespace
  (c++-ts-mode . (lambda ()
                   (push '((n-p-gp nil nil "namespace_definition") parent-bol 0)
                         (alist-get 'cpp treesit-simple-indent-rules)))))

;; Code folding using treesit.el
(use-package treesit-fold
  :hook (prog-mode . (lambda ()
                       (treesit-fold-mode)
                       (treesit-fold-indicators-mode)
                       (treesit-fold-line-comment-mode)))
  :bind (:map treesit-fold-mode-map
              ("C-c TAB" . treesit-fold-toggle)
              ("C-c [" . treesit-fold-open-all)
              ("C-c ]" . treesit-fold-close-all)))

;; Which key, included after Emacs 30.
(use-package which-key
  :init
  (setq which-key-idle-delay 1)
  :config
  (which-key-mode))

(use-package lsp-mode
  :hook ((c-ts-mode . lsp)
         (c-ts-mode . (lambda () (add-hook 'before-save-hook #'lsp-format-buffer nil t)))
         (c++-ts-mode . lsp)
         (c++-ts-mode . (lambda () (add-hook 'before-save-hook #'lsp-format-buffer nil t))))
  :commands lsp
  :bind (("C-c f" . lsp-format-buffer))
  :config
  (setopt lsp-completion-provider :capf
          lsp-enable-on-type-formatting nil
          lsp-enable-indentation nil
          lsp-idle-delay 0.5))

(use-package company
  :ensure t
  :hook ((c-ts-mode . company-mode)
         (c++-ts-mode . company-mode))
  :bind ("M-/" . #'company-complete)
  :config
  (setopt company-idle-delay 0.1
          company-minimum-prefix-length 1
          company-backends '(company-capf)))

(use-package lsp-ui
  :ensure t
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setopt lsp-ui-sideline-enable t
          lsp-ui-doc-enable t))
