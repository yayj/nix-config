;; Global Settings

(setopt inhibit-startup-screen t
        cursor-type 'hbar)

;; Set tab size to 2 for all mode
(setopt indent-tabs-mode nil
        make-backup-files nil
        tab-width 2
        standard-indent 2
        c-basic-offset 2
        python-indent-offset 2
        js-indent-level 2
        perl-indent-level 2
        sh-basic-offset 2
        tcl-indent-level 2)

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


;; Initialize package sources
(require 'package)
(setopt package-archives '(("melpa" . "https://melpa.org/packages/")
                           ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setopt use-package-always-ensure t)

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
  :hook ((c-ts-mode c++-ts-mode json-ts-mode nix-mode yaml-ts-mode) . format-all-mode)
  :config
  (setq format-all-formatters
        '(("C" clang-format)
          ("C++" clang-format)
          ("CMake" cmake-format)
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
;; (use-package projectile)

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
  (treesit-auto-install-all))

;; Which key, included after Emacs 30.
(use-package which-key
  :init
  (setq which-key-idle-delay 1)
  :config
  (which-key-mode))
