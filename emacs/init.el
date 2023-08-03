;; just a test, opened and edited from windows symlink
;; see if it works :-)

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
    helm))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

(global-linum-mode t) ;; enable line numbers globally
(setq inhibit-startup-message t) ;; hide the startup message
(setq default-directory "C:/Users/gerd/prg/")

;; material theme
(load-theme 'material t) ;; load material theme


(elpy-enable)
(setq elpy-rpc-python-command "python3")

(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy_module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

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
   '(magit smooth-scrolling material-theme helm flycheck elpy better-defaults))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Terminess Nerd Font Mono" :slant normal :weight normal :height 180 :width normal)))))
 ;;'(default ((t (:family "BigBlueTermPlus Nerd Font Mono" :slant normal :weight normal :height 143 :width normal)))))
