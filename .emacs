; Remplace "Yes" et "No" par y/n
(fset 'yes-or-no-p 'y-or-n-p)

; Supprime la barre de menu
(menu-bar-mode -1)

; Désactive le troncage des lignes quand elles dépassent la fenêtre
(setq truncate-lines nil)

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

; Json
(autoload 'json-mode "json-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.json$" . json-mode))

; Less
(autoload 'less-css-mode "less-css-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.less$" . less-css-mode))

; Sass
(autoload 'sass-mode "sass-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.sass$" . sass-mode))

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
