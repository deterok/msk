;; Глобальные горячие клавиши
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-=") 'text-scale-increase)

(global-set-key (kbd "C-x k")  'kill-this-buffer)

(global-set-key (kbd "C-x C-b") 'ibuffer)

(setq ibuffer-saved-filter-groups
      `(("default"
         ("Emacs" (or
                   (name . "^\\*scratch\\*$")
                   (name . "^\\*Messages\\*$")
                   (name . "^\\*Compile-Log\\*$")
                   (name . "^\\*Flycheck")))

         ("Terminals" (mode . term-mode))
         ("ED" (filename . ,(expand-file-name user-emacs-directory)))
         ("Debug" (name . "^\\*Backtrace"))
         ("Help" (or (mode . Man-mode)
                    (mode . woman-mode)
                    (mode . Info-mode)
                    (mode . Help-mode)
                    (mode . help-mode))))))

(add-hook 'ibuffer-mode-hook
          (lambda() (ibuffer-switch-to-saved-filter-groups "default")))
