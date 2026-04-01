(setq inhibit-startup-message t) ; Don't show splash screen
(menu-bar-mode -1)               ; Hide menu bar
(tool-bar-mode -1)               ; Hide tool bar
(scroll-bar-mode -1)             ; Hide scroll bar
(set-fringe-mode 10)             ; Margin left and right

(setq visible-bell t)                       ; Blink screen instead of ringing bell
					; "custom file" different from init.el
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(setq use-dialog-box nil)              ; no UI dialogs

(setq history-length 25)

(global-display-line-numbers-mode 1)   ; Show line numbers
(save-place-mode 1)                    ; Remember place in file
(setq global-auto-revert-mode 1)            ; auto-revert files when changed outside
(setq global-auto-revert-non-file-buffers t); do the same for other buffers
(recentf-mode 1)                       ; Remember recent files
(savehist-mode 1)                      ; Save minibuffer entries

(load-theme 'leuven-dark)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit) ; ESC quits prompt

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(package-install 'use-package)
(require 'use-package)
(setq use-package-always-ensure t)

(use-package command-log-mode)

(use-package rainbow-delimiters :hook (prog-mode . rainbow-delimiters-mode))

(defun padi/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1))

(use-package org
  :hook (org-mode . padi/org-mode-setup)
  :config
  (setq org-ellipsis " ▾"
  	org-hide-emphasis-markers t))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(dolist (face '((org-level-1 . 1.2)
  		(org-level-2 . 1.1)
  		(org-level-3 . 1.05)
  		(org-level-4 . 1.0)
  		(org-level-5 . 1.1)
  		(org-level-6 . 1.1)
  		(org-level-7 . 1.1)
  		(org-level-8 . 1.1))))

(require 'org-indent)

(set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
(set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
(set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
(set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
(set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (python . t)))

(setq org-confirm-babel-evaluate nil)

(require 'org-tempo)
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))

(defun padi/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . padi/lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t))


