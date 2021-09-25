;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Minh Tran"
      user-mail-address "minhtrannhat2001@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 16)
      doom-big-font (font-spec :family "JetBrainsMono Nerd Font" :size 26)
      doom-variable-pitch-font (font-spec :family "Overpass" :size 16)
      doom-unicode-font (font-spec :family "JuliaMono")
      doom-serif-font (font-spec :family "IBM Plex Mono" :weight 'light))

(setq doom-theme 'doom-nord)

(with-eval-after-load 'doom-themes
  (doom-themes-treemacs-config))
(setq doom-themes-treemacs-theme "doom-colors")

(setq org-directory "~/org/")

(setq display-line-numbers-type 'relative)

;; Discord Rich Presence
(require 'elcord)
(elcord-mode)
(setq elcord-use-major-mode-as-main-icon 't)

;; Clangd lsp for C/C++ dev
(setq lsp-clients-clangd-args '("-j=3"
                                "--background-index"
                                "--clang-tidy"
                                "--completion-style=detailed"
                                "--header-insertion=never"
                                "--header-insertion-decorators=0"))
(after! lsp-clangd (set-lsp-priority! 'clangd 2))

;; I mindlessly press ESC, so stop me from wreaking havoc
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; update the git gutter
(custom-set-variables
 '(git-gutter:update-interval 1))

;; tree-sitter syntax highlighting
(use-package! tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

;; for verifying commits with gpg
(use-package! pinentry
        :init (setq epg-pinentry-mode `loopback)
            (pinentry-start))

;; both jk and kj now works
(setq evil-escape-unordered-key-sequence 't)

;; org org
(setq +latex-viewers '(zathura))

(after! org (setq org-hide-emphasis-markers t))
(add-hook! org-mode (electric-indent-local-mode -1))
(add-hook! org-mode :append
           #'visual-line-mode)

;; tabs tabs
(setq centaur-tabs-cycle-scope 'tabs)

;; fish fish
(setq vterm-shell 'fish)

(defun doom-modeline-conditional-buffer-encoding ()
  "We expect the encoding to be LF UTF-8, so only show the modeline when this is not the case"
  (setq-local doom-modeline-buffer-encoding
              (unless (and (memq (plist-get (coding-system-plist buffer-file-coding-system) :category)
                                 '(coding-category-undecided coding-category-utf-8))
                           (not (memq (coding-system-eol-type buffer-file-coding-system) '(1 2))))
                t)))

(add-hook 'after-change-major-mode-hook #'doom-modeline-conditional-buffer-encoding)

(after! company
  (setq company-idle-delay 0.5
        company-minimum-prefix-length 2)
  (setq company-show-numbers t)
  (add-hook 'evil-normal-state-entry-hook #'company-abort)) ;; make aborting less annoying.

(setq-default history-length 1000)
(setq-default prescient-history-length 1000)
