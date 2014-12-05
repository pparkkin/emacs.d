(when window-system (set-frame-size (selected-frame) 98 42))
(setq-default inhibit-startup-screen t)
(tool-bar-mode -1)
;(tabbar-mode 1)
(cua-mode 1)
(set-face-attribute 'default nil :height 150)

;;(require 'smooth-scroll)
(setq scroll-step 1)
(setq scroll-margin 1)

(setq mac-option-modifier nil
      mac-command-modifier 'meta
      x-select-enable-clipboard t)

(setq default-directory "/Users/pparkkin/")
(setq-default indent-tabs-mode nil)
(setq-default column-number-mode t)

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(setq package-archives '(("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

(defvar my-packages '(zenburn-theme
                      starter-kit
                      starter-kit-lisp
                      paredit
                      highlight-parentheses
                      clojure-mode
                      clojure-test-mode
                      tuareg
                      utop
                      merlin
                      haskell-mode))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(load-theme 'zenburn t)

(setq hl-paren-colors
      '("red1" "orange1" "yellow1" "green1" "cyan1"
        "slateblue1" "magenta1" "purple"))

;; Keybindings or tabbar
(global-set-key [M-left] 'tabbar-backward-tab)
(global-set-key [M-right] 'tabbar-forward-tab)

(defun lisp-stuff ()
  (highlight-parentheses-mode t)
  (paredit-mode t))
(add-hook 'clojure-mode-hook
          'lisp-stuff)
(add-hook 'emacs-lisp-mode-hook
          'lisp-stuff)
(add-hook 'eval-expression-minibuffer-setup-hook
          'lisp-stuff)

(add-hook 'tuareg-mode-hook 'tuareg-imenu-set-imenu)
(setq auto-mode-alist
      (append '(("\\.ml[ily]?$" . tuareg-mode)
                ("\\.topml$" . tuareg-mode))
              auto-mode-alist)) 
(autoload 'utop-setup-ocaml-buffer "utop" "Toplevel for OCaml" t)
(add-hook 'tuareg-mode-hook 'utop-setup-ocaml-buffer)
(add-hook 'tuareg-mode-hook 'merlin-mode)
(setq merlin-use-auto-complete-mode t)
(setq merlin-error-after-save nil)

(add-hook 'haskell-mode-hook 'haskell-indent-mode)
