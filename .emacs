; Active le support de la souris dans xterm
(xterm-mouse-mode)

; Scroll d'une ligne à la fois avec le clavier
(setq scroll-step 1)

; Scroll d'une ligne à la fois avec la souris
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))

; Remplace "Yes" et "No" par y/n
(fset 'yes-or-no-p 'y-or-n-p)

; PageUp / PageDown vont en haut et en bas des buffers au lieu de bipper
(setq scroll-error-top-bottom t)

; Supprime la barre de menu
(menu-bar-mode -1)

; Active le troncage des lignes quand elles dépassent la fenêtre
(set-default 'truncate-lines t)

; Empèche l'affichage de la page de démarrage
(setq inhibit-startup-message t)

; Affiche le numéro de colonne en plus du numéro de ligne
(column-number-mode t)

; Empèche les backup
(setq backup-inhibited t)
(setq auto-save-default nil)

; Force l'utilisation de quatre espaces dans divers modes
(setq-default indent-tabs-mode nil)
(setq-default c-basic-offset 4)
(setq-default yaml-indent-offset 4)
(setq-default sgml-basic-offset 4)

; Retire les espaces en fin de ligne à chaque sauvegarde
(add-hook 'before-save-hook 'delete-trailing-whitespace)

; Aligne correctement les tableaux PHP
(c-set-offset 'arglist-close 'c-lineup-arglist-operators)

; Corrige les chiffres du pad avec Putty
(global-set-key "\eOp" "0")
(global-set-key "\eOq" "1")
(global-set-key "\eOr" "2")
(global-set-key "\eOs" "3")
(global-set-key "\eOt" "4")
(global-set-key "\eOu" "5")
(global-set-key "\eOv" "6")
(global-set-key "\eOw" "7")
(global-set-key "\eOx" "8")
(global-set-key "\eOy" "9")
(global-set-key "\eOl" "+")
(global-set-key "\eOQ" "/")
(global-set-key "\eOR" "*")
(global-set-key "\eOS" "-")
(global-set-key "\eOn" ".")

;
(global-set-key (read-kbd-macro "ESC <right>") 'windmove-right)
(global-set-key (read-kbd-macro "ESC <left>") 'windmove-left)
(global-set-key (read-kbd-macro "ESC <up>") 'windmove-up)
(global-set-key (read-kbd-macro "ESC <down>") 'windmove-down)

; Insère le dossier site-lisp local dans le PATH
(add-to-list 'load-path "~/.emacs.d/site-lisp/")

; Dépendance du Jade mode
(autoload 'sws-mode "sws-mode" nil t)

; Javascript
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(setq js2-include-jslint-globals t)

; Json
(autoload 'json-mode "json-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.json$" . json-mode))

; Less
(autoload 'less-css-mode "less-css-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.less$" . less-css-mode))

; Haml
(autoload 'haml-mode "haml-mode" nil t)

; Sass
(autoload 'sass-mode "sass-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.scss$" . sass-mode))

; PHP
(autoload 'php-mode "php-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.\\(php[45]?\\|phtml\\|inc\\)$" . php-mode))

; Markdown
(autoload 'markdown-mode "markdown-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))

; YAML
(autoload 'yaml-mode "yaml-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.ya?ml$" . yaml-mode))

; CMake
(autoload 'cmake-mode "cmake-mode" nil t)
(add-to-list 'auto-mode-alist '("CMakeLists\\.txt\\'" . cmake-mode))

; Lemon
(autoload 'lemon-mode "lemon-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.lm$" . lemon-mode))

; Castel
(autoload 'castel-mode "castel-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.ct$" . castel-mode))

; Jinja 2
(autoload 'jinja2-mode "jinja2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.jinja$" . jinja2-mode))

; Minor mode permettant de faire défiler deux buffers cote-à-cote
(defun Xsync-window (&optional display-start)
  "Synchronize point position other window in current frame. Only works if there are exactly two windows in the active wrame not counting the minibuffer."
  (interactive)
  (when (= (count-windows 'noMiniBuf) 2)
    (let ((p (line-number-at-pos))
      (start (line-number-at-pos (or display-start (window-start))))
      (vscroll (window-vscroll)))
      (other-window 1)
      (goto-char (point-min))
      (setq start (line-beginning-position start))
      (forward-line (1- p))
      (set-window-start (selected-window) start)
      (set-window-vscroll (selected-window) vscroll)
      (other-window 1)
      (unless display-start
        (redisplay t))
      )))

(define-minor-mode sync-window-mode
  "Synchronized view of two buffers in two side-by-side windows."
  :group 'windows
  (unless (boundp 'sync-window-mode-active)
    (setq sync-window-mode-active nil))
  (if sync-window-mode
      (progn
        (add-hook 'post-command-hook 'sync-window-wrapper 'append t)
        (add-to-list 'window-scroll-functions 'sync-window-wrapper)
        (Xsync-window))
    (remove-hook 'post-command-hook 'sync-window-wrapper t)
    (setq window-scroll-functions (remove 'sync-window-wrapper window-scroll-functions))))

(defun sync-window-wrapper (&optional window display-start)
  "This wrapper makes sure that `sync-window' is fired from `post-command-hook' only when the buffer of the active window is in `sync-window-mode'."
  (unless sync-window-mode-active
    (setq sync-window-mode-active t)
    (with-selected-window (or window (selected-window))
      (when sync-window-mode
        (Xsync-window display-start)))
    (setq sync-window-mode-active nil)))

(defun sync-window-dual ()
  "Toggle synchronized view of two buffers in two side-by-side windows simultaneously."
  (interactive)
  (if (not (= (count-windows 'noMiniBuf) 2))
      (error "restricted to two windows")
    (let ((mode (if sync-window-mode 0 1)))
      (sync-window-mode mode)
      (with-selected-window (selected-window)
        (other-window 1)
        (sync-window-mode mode)))))

(custom-set-variables

 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(js2-include-jslint-globals t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
