;; aibix' EMACS Config

(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(require 'package)
(add-to-list 'package-archives
         '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    elpy
    flycheck
    material-theme
    smooth-scrolling
    helm
    helm-tramp
    helm-themes
    highlight-indent-guides))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

(setq inhibit-startup-message t) ;; hide the startup message

;; load theme
(load-theme 'deeper-blue t)

;; line-numbers and fringe/gutter setting
(global-linum-mode t) ;; enable line numbers globally
(global-hl-line-mode t) ;; enable visible horizontal line
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode) ;; add hook for indent guides
(set-face-attribute 'fringe nil :background "gray12")
(add-to-list 'default-frame-alist '(left-fringe . 11))
(add-to-list 'default-frame-alist '(right-fringe . 0))
(setq-default left-fringe-width 11)
(setq-default right-fringe-width 0)

;; set home-dir and default-directory according to OS
(setq home-dir
      (cond 
        ((eq system-type 'windows-nt) 
         (concat "/C:/Users/" user-login-name "/")) 
        (t (concat "/home/" user-login-name "/"))))
(setq default-directory home-dir)

;; python addons
(elpy-enable)
(setq elpy-rpc-python-command "python3")

(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy_module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; convenience and looks stuff
(require 'smooth-scrolling)
(setq smooth-scroll-margin 5)

(setq scroll-step           1
      scroll-conservatively 100000)

;;(require 'helm-config)
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(helm-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(menu-bar-mode nil)
 '(package-selected-packages
   '(helm-themes helm-tramp highlight-indent-guides standard-dirs platformio-mode magit smooth-scrolling material-theme helm flycheck elpy better-defaults))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Terminess Nerd Font Mono" :slant normal :weight normal :height 150 :width normal)))))

