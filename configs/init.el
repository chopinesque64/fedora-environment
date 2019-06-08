;; System Settings
(setq inhibit-splash-screen t)
(toggle-frame-maximized)

(menu-bar-mode 1)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(global-linum-mode 1)

;; Packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(package-install 'use-package)
(setq use-package-always-ensure t)

(use-package nord-theme 
  :ensure t
  :load-path "themes"
  :config
  (load-theme 'nord t))

(use-package evil
  :config
  (evil-mode 1))

(use-package cargo
  :init
  (add-hook 'rust-mode-hook 'cargo-minor-mode))

(use-package company
  :init
  (setq company-idle-delay 0.1)
  :config
  (global-company-mode 1))

(use-package racer
  :init
  (setq racer-rust-src-path
        (concat "~/.rustup/toolchains/"
                "stable-x86_64-unknown-linux-gnu"
                "/lib/rustlib/src/rust/src"))
  (add-hook 'rust-mode-hook (lambda () (racer-mode)))
  (add-hook 'racer-mode-hook (lambda () (eldoc-mode 1))))

(use-package rust-mode)

(use-package smartparens
  :init
  (dolist (mode-hook
	   '(rust-mode-hook
	     emacs-lisp-mode-hook))
    (add-hook mode-hook (lambda () (smartparens-strict-mode 1))))
  :config
  (require 'smartparens-config))

(setq custom-file (make-temp-file "emacs-custom"))
