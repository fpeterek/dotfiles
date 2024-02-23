;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Filip Peterek"
      user-mail-address "fpeterek@seznam.cz")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-vibrant)
(setq doom-theme 'doom-horizon)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)
(setq doom-font 
    (font-spec :family "Fira Code" :size 17))

(set-face-bold-p 'bold nil)

(defun cm/clean-fonts()
  "Eliminate bold and underline fonts"
  (interactive)
  (mapc
    (lambda (face)
      (set-face-attribute face nil :weight 'normal :underline nil))
    (face-list)))

(add-hook 'tree-sitter-mode-hook #'cm/clean-fonts)

; (setq doom-font 
;      (font-spec :family "Fira Code Regular Nerd Font Complete Mono" :size 17))

(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)
(add-hook 'tex-mode-hook #'display-fill-column-indicator-mode)
(add-hook 'TeX-mode-hook #'display-fill-column-indicator-mode)
(add-hook 'latex-mode-hook #'display-fill-column-indicator-mode)
(add-hook 'LaTeX-mode-hook #'display-fill-column-indicator-mode)

(setq-default display-fill-column-indicator-column 100)

(require 'company)
(setq company-idle-delay 0.1
      company-minimum-prefix-length 1)

(setq completion-styles '(flex))

(setq company-selection-wrap-around t)

(setq scroll-margin 5)

(setq next-error-find-buffer-function 'next-error-buffer-unnavigated-current)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

(remove-hook 'doom-first-input-hook #'evil-snipe-mode)
(after! evil-snipe
    (evil-snipe-mode -1)
    (evil-snipe-override-mode -1))

(define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
(define-key evil-visual-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "C-x") 'evil-numbers/dec-at-pt)
(define-key evil-visual-state-map (kbd "C-x") 'evil-numbers/dec-at-pt)

(map! 
  :leader 
  :desc "Goto definition"
  "g d"
  #'evil-goto-definition)

(map! 
  :leader 
  :desc "Goto reference"
  "g r"
  #'lsp-find-references)

(map! 
  :leader 
  :desc "Rename"
  "r n"
  #'lsp-rename)

(map!
  :leader
  :desc "Toggle Neotree"
    "n t"
    #'+neotree/open)

(map!
  :leader
  :desc "Open Vterm"
    "v t"
    #'vterm)

(map!
  :leader
  :desc "Show Hover"
    "s h"
    #'lsp-ui-doc-show)

(map!
  :leader
  :desc "Next Error"
    "d n"
    #'next-error)

(map!
  :leader
  :desc "Previous Error"
    "d p"
    #'previous-error)

(map!
  :leader
  :desc "Format Buffer"
    "c f"
    #'lsp-format-buffer)

(map!
  :leader
  :desc "Grep Project"
    "f g"
    #'+default/search-project)

(map!
  :leader
  :desc "Find File"
    "f f"
    #'project-find-file)

(defvar my/keys-keymap (make-keymap)
  "Keymap for my/keys-mode")

(define-minor-mode my/keys-mode
  "Minor mode for my personal keybindings."
  :init-value t
  :global t
  :keymap my/keys-keymap)

;; The keymaps in `emulation-mode-map-alists' take precedence over
;; `minor-mode-map-alist'
(add-to-list 'emulation-mode-map-alists
             `((my/keys-mode . ,my/keys-keymap)))

(define-key my/keys-keymap (kbd "C-h") 'evil-window-left)
(define-key my/keys-keymap (kbd "C-j") 'evil-window-down)
(define-key my/keys-keymap (kbd "C-k") 'evil-window-up)
(define-key my/keys-keymap (kbd "C-l") 'evil-window-right)

(define-key evil-normal-state-map (kbd "C-<left>") 'shrink-window-horizontally)
(define-key evil-normal-state-map (kbd "C-<right>") 'enlarge-window-horizontally)
(define-key evil-normal-state-map (kbd "C-<up>") 'shrink-window)
(define-key evil-normal-state-map (kbd "C-<down>") 'enlarge-window)

(remove-hook 'doom-first-buffer-hook #'smartparens-global-mode)

(use-package! tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(after! doom-themes
  (remove-hook 'doom-load-theme-hook #'doom-themes-neotree-config))

(use-package! neotree
  :config
  (setq neo-theme 'icons))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
