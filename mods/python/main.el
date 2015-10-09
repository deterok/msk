(msk/require-pkgs '(f
                    s
                    pythonic
                    anaconda-mode
                    company-anaconda
                    virtualenvwrapper))


;; Настраиваем автодополнение и различе подсказки для python-mode
(progn
  (require 'anaconda-mode)
  (require 'company-anaconda)
  (require 'eldoc)

  (msk/add-company-backend 'company-anaconda)
  (add-hook 'python-mode-hook #'anaconda-mode)
  (add-hook 'python-mode-hook #'eldoc-mode))


;; Настраиваем IPython вместо стандартного интерпритатора Python
(setq-default
 python-shell-interpreter "ipython"
 python-shell-interpreter-args ""
 python-shell-prompt-regexp "In \\[[0-9]+\\]: "
 python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
 python-shell-completion-setup-code
 "from IPython.core.completerlib import module_completion"
 python-shell-completion-module-string-code
 "';'.join(module_completion('''%s'''))\n"
 python-shell-completion-string-code
 "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")


;; Горячии клавиши для перехода к объявлению объекта и назад
(define-key anaconda-mode-map (kbd "M-.") 'anaconda-mode-goto)
(define-key anaconda-mode-map (kbd "M-,") 'anaconda-nav-pop-marker)


(defun python-shell-send-buffer-with-main ()
  "Запуск буфера как main модуля"
  (interactive)
  (python-shell-send-buffer t))

;; Горячая клавиша для запуска модуля вместе с main условием
(define-key anaconda-mode-map (kbd "C-c C-e")
  'python-shell-send-buffer-with-main)
