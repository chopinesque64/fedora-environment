;; System Settings
(setq inhibit-splash-screen t)

(menu-bar-mode 1)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(setq global-linum-mode t)

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

(setq custom-file (make-temp-file "emacs-custom"))
