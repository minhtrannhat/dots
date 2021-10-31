;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "minhtrannhat"
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

(setq fancy-splash-image "/home/minhradz/.doom.d/marivector.png")

(defun synchronize-theme ()
  (let* ((light-theme 'doom-nord-light)
         (dark-theme 'doom-nord)
         (start-time-light-theme 6)
         (end-time-light-theme 18)
         (hour (string-to-number (substring (current-time-string) 11 13)))
         (next-theme (if (member hour (number-sequence start-time-light-theme end-time-light-theme))
                         light-theme dark-theme)))
    (when (not (equal doom-theme next-theme))
      (setq doom-theme next-theme)
      (load-theme next-theme t))))

(run-with-timer 0 900 'synchronize-theme)

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

;; Whether display the icon for `major-mode'. It respects `doom-modeline-icon'.
(setq doom-modeline-major-mode-icon t)

;; Whether display the colorful icon for `major-mode'.
;; It respects `all-the-icons-color-icons'.
(setq doom-modeline-major-mode-color-icon t)

;; Whether display the icon for the buffer state. It respects `doom-modeline-icon'.
(setq doom-modeline-buffer-state-icon t)

;; Whether display the modification icon for the buffer.
;; It respects `doom-modeline-icon' and `doom-modeline-buffer-state-icon'.
(setq doom-modeline-buffer-modification-icon t)

;; Whether to use unicode as a fallback (instead of ASCII) when not using icons.
(setq doom-modeline-unicode-fallback nil)

;; Whether display the minor modes in the mode-line.
(setq doom-modeline-minor-modes nil)

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

;; Deft - a Major mode for text searching
(setq deft-directory org-roam-directory)
(setq deft-recursive t)
(setq deft-default-extension "org")
(setq deft-use-filter-string-for-filename t)

;; Function for inserting node into Org Roam
(defun org-roam-node-insert-immediate (arg &rest args)
  (interactive "P")
  (let ((args (cons arg args))
        (org-roam-capture-templates (list (append (car org-roam-capture-templates)
                                                  '(:immediate-finish t)))))
    (apply #'org-roam-node-insert args)))

(map! :leader
        :desc "Insert node immediately"
        "n r I" #'org-roam-node-insert-immediate)
