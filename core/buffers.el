;; Глобальные горячие клавиши

;; горячии клавиши для увиичения и уменьшения шрифта в буфере
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-=") 'text-scale-increase)


;; Убивает буфер
(global-set-key (kbd "C-x k")  'kill-this-buffer)


;; Заменяем обычный список буферов на ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)


;; Создаем матчинг-группы для списка буферов
(setq ibuffer-saved-filter-groups
      `(("default"
         ("Emacs" (or
                   (name . "^\\*Messages\\*$")
                   (name . "^\\*Compile-Log\\*$")
                   (name . "^\\*Flycheck")))
         ("Scratches" (name . "^\\*scratch"))
         ("Terminals" (mode . term-mode))
         ("ED" (filename . ,(expand-file-name user-emacs-directory)))
         ("Debug" (name . "^\\*Backtrace"))
         ("Help" (or (mode . Man-mode)
                    (mode . woman-mode)
                    (mode . Info-mode)
                    (mode . Help-mode)
                    (mode . help-mode))))))


;; Выставляем созданные ранее матчинг-грппы по-умолчанию
(add-hook 'ibuffer-mode-hook
          (lambda() (ibuffer-switch-to-saved-filter-groups "default")))
