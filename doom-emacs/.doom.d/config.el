;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "minhtrannhat"
      user-mail-address "minhtrannhat@minhtrannhat.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 18)
      doom-big-font (font-spec :family "JetBrainsMono Nerd Font" :size 26)
      doom-variable-pitch-font (font-spec :family "Overpass" :size 16)
      doom-unicode-font (font-spec :family "JuliaMono")
      doom-serif-font (font-spec :family "IBM Plex Mono" :weight 'light))

(setq doom-emoji-fallback-font-families nil)
(setq doom-symbol-fallback-font-families nil)

(add-hook 'prog-mode-hook #'pixel-scroll-mode)
(add-hook 'text-mode-hook #'pixel-scroll-mode)

(setq fancy-splash-image "/home/minhradz/.doom.d/marivector.png")

(defun synchronize-theme ()
(let* ((light-theme 'doom-nord-light)
        (dark-theme 'doom-nord)
        (start-time-light-theme 6)
        (end-time-light-theme 16)
        (hour (string-to-number (substring (current-time-string) 11 13)))
        (next-theme (if (member hour (number-sequence start-time-light-theme end-time-light-theme))
                light-theme dark-theme)))
        (when (not (equal doom-theme next-theme))
                (setq doom-theme next-theme)
        (load-theme next-theme t))))

(run-with-timer 0 900 'synchronize-theme)

(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled

(with-eval-after-load 'doom-themes
  (doom-themes-treemacs-config))
(setq doom-themes-treemacs-theme "doom-colors")

(setq org-directory "~/org/")

(setq display-line-numbers-type 'relative)

(add-hook 'spell-fu-mode-hook
  (lambda ()
    (spell-fu-dictionary-add (spell-fu-get-ispell-dictionary "en"))
    (spell-fu-dictionary-add
      (spell-fu-get-personal-dictionary "en-personal" "/home/minhradz/.aspell.en.pws"))))

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
 '(git-gutter:update-interval 0.02))

;; ;; tree-sitter syntax highlighting
;; (use-package! tree-sitter
;;   :config
;;   (require 'tree-sitter-langs)
;;   (global-tree-sitter-mode)
;;   (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

(require 'elcord)
(elcord-mode)
(setq elcord-use-major-mode-as-main-icon 't)

;; gpg
(setq epg-pinentry-mode 'loopback)

;; both jk and kj now works
(setq evil-escape-unordered-key-sequence 't)

;; org org
(setq +latex-viewers '(zathura))
;; auto render latex in org mode
(add-hook 'org-mode-hook 'org-fragtog-mode)

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
  (setq company-idle-delay 1)
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

(setq org-roam-dailies-directory "daily/")

(setq org-roam-dailies-capture-templates
      '(("d" "default" entry
         "* %?"
         :target (file+head "%<%Y-%m-%d>.org"
                            "#+title: %<%Y-%m-%d>\n* What I did today\n* What was on my mind"))))

(defun org-roam-rg-search ()
  "Search org-roam directory using consult-ripgrep. With live-preview."
  (interactive)
  (let ((consult-ripgrep-command "rg --null --ignore-case --type org --line-buffered --color=always --max-columns=500 --no-heading --line-number . -e ARG OPTS"))
    (consult-ripgrep org-roam-directory)))

(map! :leader
        :desc "Search org-roam with consult-ripgrep"
        "n r F" #'org-roam-rg-search)

(setq org-roam-node-display-template
#("${doom-hierarchy:20} ${doom-type:12} ${doom-tags:42}" 20 35
  (face font-lock-keyword-face)
  36 51
  (face org-tag))
)

(setq avy-all-windows 't)

;; Disables lsp-signature-auto-activate
;; Looking at you, rustic mode
(after! lsp-mode
  (setq lsp-signature-auto-activate nil))

;; this never worked lol
(lsp-treemacs-sync-mode 1)

;; bitmap very funni
(setq highlight-indent-guides-method 'bitmap)

;; magit delta looks so good
(add-hook 'magit-mode-hook (lambda () (magit-delta-mode +1)))

;; keybind to disable search highlighting (like :set noh)
(map! :leader
      :desc "Clear search highlight"
      "s c"
      #'evil-ex-nohighlight)

;; We do a little bit of finger pointing
(use-package blamer
  :bind (("s-i" . blamer-show-commit-info))
  :defer 20
  :custom
  (blamer-idle-time 0.3)
  (blamer-min-offset 40)
  :custom-face
  (blamer-face ((t :foreground "#7a88cf"
                    :background nil
                    :height 110
                    :italic t))))

;; elfeed the rss reader
(after! elfeed
  (setq elfeed-search-filter "@1-month-ago"))
(add-hook! 'elfeed-search-mode-hook #'elfeed-update)

(map! :map elfeed-search-mode-map
      :after elfeed-search
      [remap kill-this-buffer] "q"
      [remap kill-buffer] "q"
      :n doom-leader-key nil
      :n "q" #'+rss/quit
      :n "e" #'elfeed-update
      :n "r" #'elfeed-search-untag-all-unread
      :n "u" #'elfeed-search-tag-all-unread
      :n "s" #'elfeed-search-live-filter
      :n "l" #'elfeed-search-show-entry
      :n "p" #'elfeed-show-pdf
      :n "+" #'elfeed-search-tag-all
      :n "-" #'elfeed-search-untag-all
      :n "S" #'elfeed-search-set-filter
      :n "b" #'elfeed-search-browse-url
      :n "y" #'elfeed-search-yank)
(map! :map elfeed-show-mode-map
      :after elfeed-show
      [remap kill-this-buffer] "q"
      [remap kill-buffer] "q"
      :n doom-leader-key nil
      :nm "h" #'+rss/delete-pane
      :nm "o" #'elfeed-goodies/show-ace-link
      :nm "RET" #'org-ref-elfeed-add
      :nm "n" #'elfeed-show-next
      :nm "N" #'elfeed-show-prev
      :nm "p" #'elfeed-show-pdf
      :nm "+" #'elfeed-show-tag
      :nm "-" #'elfeed-show-untag
      :nm "s" #'elfeed-show-new-live-search
      :nm "y" #'elfeed-show-yank)


(after! elfeed-search
  (set-evil-initial-state! 'elfeed-search-mode 'normal))
(after! elfeed-show-mode
  (set-evil-initial-state! 'elfeed-show-mode   'normal))

(after! evil-snipe
  (push 'elfeed-show-mode   evil-snipe-disabled-modes)
  (push 'elfeed-search-mode evil-snipe-disabled-modes))

(setq org-agenda-time-grid
      (quote
       ((daily today remove-match)
        (800 1200 1600 2000)
        "......" "----------------")))

;; Clojure stuffs
(setq clojure-indent-style :always-align)

(defun delete-file-and-buffer ()
  "Kill the current buffer and deletes the file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if filename
        (if (y-or-n-p (concat "Do you really want to delete file " filename " ?"))
            (progn
              (delete-file filename)
              (message "Deleted file %s." filename)
              (kill-buffer)))
      (message "Not a file visiting buffer!"))))

;; email stuffs
;; Each path is relative to the path of the maildir you passed to mu
(set-email-account! "minhtrannhat.com"
  '((mu4e-sent-folder       . "/minhtrannhat@minhtrannhat.com/Sent")
    (mu4e-drafts-folder     . "/minhtrannhat@minhtrannhat.com/Drafts")
    (mu4e-trash-folder      . "/minhtrannhat@minhtrannhat.com/Trash")
    (mu4e-refile-folder     . "/minhtrannhat@minhtrannhat.com/All Mail")
    (smtpmail-smtp-user     . "minhtrannhat@minhtrannhat.com")
    (mu4e-compose-signature . "Minh Tran"))
  t)

(setq sendmail-program "/usr/bin/msmtp"
      send-mail-function #'smtpmail-send-it
      message-sendmail-f-is-evil t
      message-sendmail-extra-arguments '("--read-envelope-from")
      message-send-mail-function #'message-send-mail-with-sendmail)
