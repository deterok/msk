;; Глобальные горячие клавиши
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-=") 'text-scale-increase)

(global-set-key (kbd "C-x k")  'kill-this-buffer)

(global-set-key (kbd "C-x C-b") 'ibuffer)

(setq ibuffer-saved-filter-groups
      `(("default"
         ("Terminals" (mode . term-mode))
         ("emacs.d" (filename . ,(expand-file-name user-emacs-directory)))
	 ("Help" (or (mode . Man-mode)
                     (mode . woman-mode)
                     (mode . Info-mode)
                     (mode . Help-mode)
                     (mode . help-mode)))
         ("Emacs internal" (or (name . "*Messages*")
                               (name . "*Completions*")
                               (name . "*Helm log*")
                               (name . "*helm recentf*")
                               (name . "*ESS*")
                               (name . "*Compile-Log*"))))))
