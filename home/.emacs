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

; Insère le dossier site-lisp local dans le PATH
(add-to-list 'load-path "~/.emacs.d/site-lisp/")

; Dépendance du Jade mode
(autoload 'sws-mode "sws-mode" nil t)

; CSV
(autoload 'csv-mode "csv-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.csv$" . csv-mode))

; Javascript
(autoload 'web-mode "web-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . web-mode))

(add-hook 'web-mode-hook
    (lambda ()
        ;; short circuit js mode and just do everything in jsx-mode
        (if (equal web-mode-content-type "javascript")
            (web-mode-set-content-type "jsx")
            (message "now set to: %s" web-mode-content-type))))

; Json
(autoload 'web-mode "web-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.json$" . web-mode))

; Less
(autoload 'web-mode "web-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.less$" . web-mode))

; Sass
(autoload 'web-mode "web-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.scss$" . web-mode))

; PHP
(autoload 'web-mode "web-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.php$" . web-mode))

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
