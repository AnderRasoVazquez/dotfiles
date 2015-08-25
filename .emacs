(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)


; Auto instalar programas si no estan instalados
(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.

Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))

;; Make sure to have downloaded archive description.
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

;; Activate installed packages
(package-initialize)

;; Assuming you wish to install "iedit" and "magit"
(ensure-package-installed 'iedit
                          'magit
                          'evil
                          'magit
                          'helm
                          'projectile
			  'evil-commentary
			  'rainbow-delimiters
			  'monokai-theme
			  ;; 'solarized
			  'elpy ;; requiser rope epc elpy importmagic flake8
                          'powerline)

(add-to-list 'load-path "~/.emacs.d/lisp/")

;; (require 'remind-conf-mode)
;; (add-to-list 'auto-mode-alist '("\\.reminders\\'" . remind-conf-mode))

(require 'evil)
(evil-mode t)

(require 'evil-surround)
(global-evil-surround-mode 1)

(require 'rainbow-delimiters)
;; (global-rainbow-delimiters-mode)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(require 'yasnippet)
(yas-global-mode 1)

(require 'move-text)
(move-text-default-bindings) ;; m up m dewn

;; python mode
(elpy-enable)

(require 'powerline)
(powerline-center-evil-theme)

;; guardar localización
(require 'saveplace)
(setq-default save-place t)

;; temas
(load-theme 'monokai t)

;; Números de línea relativos
;; (defvar my-linum-current-line-number 0)

;; (setq linum-format 'my-linum-relative-line-numbers)

;; (defun my-linum-relative-line-numbers (line-number)
;;   (let ((test2 (1+ (- line-number my-linum-current-line-number))))
;;     (propertize
;;      (number-to-string (cond ((<= test2 0) (1- test2))
;;                              ((> test2 0) test2)))
;;      'face 'linum)))

;; (defadvice linum-update (around my-linum-update)
;;   (let ((my-linum-current-line-number (line-number-at-pos)))
;;     ad-do-it))
;; (ad-activate 'linum-update)
(global-linum-mode t)


;; highlight line
;; (global-hl-line-mode t)

;; comentarios con gcc
(evil-commentary-mode)

;; evil cursor change color
(setq evil-insert-state-cursor '((bar . 3) "cyan")
      evil-normal-state-cursor '(box "green"))

;; non blinking cursor
(blink-cursor-mode 0)

;; markdown
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "7abf5a28ec511e7e8f5fe10978b3d63058bbd280ed2b8d513f9dd8b7f5fc9400" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "05c3bc4eb1219953a4f182e10de1f7466d28987f48d647c01f1f0037ff35ab9a" default)))
 '(markdown-command "/usr/bin/pandoc"))

;; don't create backup files
;; (setq make-backup-files nil)
;; create backup files on a directory
(defvar backup-dir "~/.emacs.d/backups/")
(setq backup-directory-alist (list (cons "." backup-dir)))

;; hide welcome screen
(setq inhibit-startup-message t)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; hide toolbar
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(evil-define-key 'normal emacs-lisp-mode-map (kbd "g C-g") 'count-words)
