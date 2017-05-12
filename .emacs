;; Add and enable MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)

;; Set theme and disable
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (wombat)))
 '(flycheck-c/c++-cppcheck-executable
   "/home/users/master/baguirrete2016/Téléchargements/cppcheck-1.78/cppcheck")
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (flycheck-irony irony company rainbow-delimiters highlight-symbol yasnippet volatile-highlights undo-tree))))

;; Dont know what this does
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; IDO mode
(require 'ido)
    (ido-mode t)

;; Show matching parenthesis
(show-paren-mode 1)

;; line number
(global-linum-mode t)
(eval-after-load "linum"
  '(set-face-attribute 'linum nil :height 90))
(setq-default left-fringe-width  5)
(setq-default right-fringe-width 0 )

;; EIdocs - show funciton argumets
;; (add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
;; (add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
;; (add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package: yasnippet                 ;;
;;                                    ;;
;; GROUP: Editing -> Yasnippet        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'yasnippet)
(yas-global-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package: volatile-highlights          ;;
;;                                       ;;
;; GROUP: Editing -> Volatile Highlights ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'volatile-highlights)
(volatile-highlights-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package: highlight-symbol             ;;
;;                                       ;;
;; GROUP: Editing -> Volatile Highlights ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'highlight-symbol)

(highlight-symbol-nav-mode)

(add-hook 'prog-mode-hook (lambda () (highlight-symbol-mode)))
(add-hook 'org-mode-hook (lambda () (highlight-symbol-mode)))

(setq highlight-symbol-idle-delay 0.2
      highlight-symbol-on-navigation-p t)

(global-set-key [(control shift mouse-1)]
                (lambda (event)
                  (interactive "e")
                  (goto-char (posn-point (event-start event)))
                  (highlight-symbol-at-point)))

(global-set-key (kbd "M-n") 'highlight-symbol-next)
(global-set-key (kbd "M-p") 'highlight-symbol-prev)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package: Rainbow-Delimiter            ;;
;;                                       ;;
;; GROUP: Editing -> Volatile Highlights ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(require 'cl-lib)
(require 'color)
(cl-loop
 for index from 1 to rainbow-delimiters-max-face-count
 do
 (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
   (cl-callf color-saturate-name (face-foreground face) 30)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package: Flycheck                     ;;
;;                                       ;;
;; GROUP: Editing -> Volatile Highlights ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package flycheck
:ensure t
:init (global-flycheck-mode))
(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'c-mode-hook 'flycheck-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package: Irony                        ;;
;;                                       ;;
;; GROUP: Editing -> Volatile Highlights ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Preventing scracth and messesges      ;;
;;                                       ;;
;; GROUP: Editing -> Volatile Highlights ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Makes *scratch* empty.
(setq initial-scratch-message "")

;; Removes *scratch* from buffer after the mode has been set.
(defun remove-scratch-buffer ()
  (if (get-buffer "*scratch*")
      (kill-buffer "*scratch*")))
(add-hook 'after-change-major-mode-hook 'remove-scratch-buffer)

;; Removes *messages* from the buffer.
(setq-default message-log-max nil)
(kill-buffer "*Messages*")

;; Removes *Completions* from buffer after you've opened a file.
(add-hook 'minibuffer-exit-hook
      '(lambda ()
         (let ((buffer "*Completions*"))
           (and (get-buffer buffer)
                (kill-buffer buffer)))))

;; Don't show *Buffer list* when opening multiple files at the same time.
(setq inhibit-startup-buffer-menu t)

;; Show only one active window when opening multiple files at the same time.
(add-hook 'window-setup-hook 'delete-other-windows)

;; No more typing the whole yes or no. Just y or n will do.
(fset 'yes-or-no-p 'y-or-n-p)


; Switch between header and source
(add-hook 'c-mode-common-hook
  (lambda() 
    (local-set-key  (kbd "C-c o") 'ff-find-other-file)))
