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
    magit
    helm
    helm-tramp
    helm-themes
    highlight-indent-guides
    indent-tools
    which-key
    helpful
    undo-tree
    ace-window
    nlinum))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

(setq inhibit-startup-message t) ;; hide the startup message

;; load theme
;;(load-theme 'wombat t)

;; undo-tree
(global-undo-tree-mode)
(setq undo-tree-auto-save-history nil)
(setq undo-tree-visualizer-diff t)

;; ace-window
(global-set-key (kbd "M-p") 'ace-window)

;; configure helpful
;; Note that the built-in `describe-function' includes both functions
;; and macros. `helpful-function' is functions only, so we provide
;; `helpful-callable' as a drop-in replacement.
(global-set-key (kbd "C-h f") #'helpful-callable)
(global-set-key (kbd "C-h v") #'helpful-variable)
(global-set-key (kbd "C-h k") #'helpful-key)
(global-set-key (kbd "C-h x") #'helpful-command)

;; Lookup the current symbol at point. C-c C-d is a common keybinding
;; for this in lisp modes.
(global-set-key (kbd "C-c C-d") #'helpful-at-point)

;; Look up *F*unctions (excludes macros).
;;
;; By default, C-h F is bound to `Info-goto-emacs-command-node'. Helpful
;; already links to the manual, if a function is referenced there.
(global-set-key (kbd "C-h F") #'helpful-function)
;; Lookup the current symbol at point. C-c C-d is a common keybinding
;; for this in lisp modes.
(global-set-key (kbd "C-c C-d") #'helpful-at-point)

;; Look up *F*unctions (excludes macros).
;;
;; By default, C-h F is bound to `Info-goto-emacs-command-node'. Helpful
;; already links to the manual, if a function is referenced there.
(global-set-key (kbd "C-h F") #'helpful-function)

;; line-numbers and fringe/gutter setting
;;
;; "old" style
(require 'nlinum)
(global-nlinum-mode t)
(setq nlinum-format "%6d\u2502")
;;
;; "new" style
;;(global-display-line-numbers-mode t) ;; enable line numbers globally

(global-hl-line-mode t) ;; enable visible horizontal line
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode) ;; add hook for indent guides
(add-hook 'prog-mode-hook 'which-key-mode) ;; add hook for which-key

;; configure colors for indent guides
;;(set-face-background 'highlight-indent-guides-odd-face "darkgray")
;;(set-face-background 'highlight-indent-guides-even-face "dimgray")
;;(set-face-foreground 'highlight-indent-guides-character-face "dimgray")

;; my test adding highlight-indentation-mode zu yaml-mode
(add-hook 'yaml-mode-hook 'highlight-indentation-mode)
;; and added indent-tools-hydra/body shortcut
(require 'indent-tools)
(add-hook 'yaml-mode-hook
	  (lambda () (define-key yaml-mode-map (kbd "C-c <") 'indent-tools-hydra/body))
)
;;(set-face-attribute 'fringe nil :background "gray20")
;;(add-to-list 'default-frame-alist '(left-fringe . 100))
;;(add-to-list 'default-frame-alist '(right-fringe . 0))
;;(setq-default left-fringe-width 5)
;;(setq-default right-fringe-width 0)

;; set home-dir and default-directory according to OS
(setq home-dir
      (cond
       ((eq system-type 'windows-nt)
        (concat "C:/Users/" user-login-name "/"))
       (t (cond
           ((string-equal user-login-name "root")
            (concat "/" user-login-name "/"))
           (t (concat "/home/" user-login-name "/"))))))

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

(setq visible-bell t)

;;(require 'helm-config)
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "M-y") #'helm-show-kill-ring)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(global-set-key (kbd "C-x C-b") #'helm-mini)
(global-set-key (kbd "C-x b") #'helm-buffers-list)
(setq helm-move-to-line-cycle-in-source t)
(helm-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(menu-bar-mode t)
 '(package-selected-packages
   '(ace-window undo-tree yaml-mode indent-tools highlight-indentation clipetty ansible ansible-doc lxc lxc-tramp nlinum which-key magit-annex helm-themes helm-tramp highlight-indent-guides standard-dirs platformio-mode magit smooth-scrolling material-theme helm flycheck elpy better-defaults))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)
 '(warning-suppress-types '((comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
