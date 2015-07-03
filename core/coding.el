(msk/require-pkgs '(autopair
                    highlight-parentheses
                    multiple-cursors
                    company
                    smart-tab-company
                    yasnippet
                    ;; auto-highlight-symbol
                    ))


(set-default 'indent-tabs-mode nil)     ;Запрещаем отступы по <TAB>
(set-default 'tab-width 4)              ;Заменяем <TAB> 4 пробелами
(add-hook 'prog-mode-hook #'linum-mode) ;Нумируем строки


;; Автоматическое управление парными скобками и кавычками (Создание/Удаление)
(require 'autopair)
(autopair-global-mode t)


;; Подсвечиваем парные скобки при наъождение курсора рядом с одной из них
(require 'paren)
(show-paren-mode t)
(set-default 'show-paren-style 'mixed)


;; Подсвечиваем парные скобки когда находимся в их блоке
(require 'highlight-parentheses)
(global-highlight-parentheses-mode t)


;; Подсвечиваем "символ" во всем буфере, когда курсор находится над одним из них
;; (require 'auto-highlight-symbol)
;; (global-auto-highlight-symbol-mode t)


;; Поддержка мультикурсоров
;; Позволяет редактировать и изменять однотипные данные одновременно в
;; нескольких местах
;; TODO: Добавить хоткеи для этого действия
(require'multiple-cursors)
(set-default 'mc/list-file (msk/concat-path msk-cache-dir "mc-list.el"))
(add-hook 'prog-mode-hook #'multiple-cursors-mode)


(defun comment-or-uncomment-line ()
  "Закоментировать или раскоментировать текущую линию"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))

(global-set-key (kbd "C-M-;") #'comment-or-uncomment-line)


;; Масштабная система автодополнения кода/текста
(progn
  (require 'company)
  (global-company-mode t)


  ;; Позволяет по <TAB> вызывать список автодополнения или управлять отступами
  (require 'smart-tab)
  (set-default 'smart-tab-completion-functions-alist '())
  (global-smart-tab-mode t)


  ;; Шаблонные выражаения на все слчае жизни для различных ЯП и не только.
  ;; Такие как циклы и синтаксические конструкци
  ;; Намеренно отделены от smart-tab, т.к. иногда замусоревают вывод company
  (progn
    (require 'yasnippet)
    (set-default 'yas-verbosity 1)
    (yas-global-mode t)
    (setq yas-prompt-functions (delete 'yas-x-prompt yas-prompt-functions))
    (global-set-key (kbd "C-<tab>") #'company-yasnippet))


  (defvar company-mode/enable-yas t
    "Включить сниппеты во все backend'ы company")


  (defun msk/company-backend-with-yas (backend)
    "Обрабатывает переданные company-backend и добавляет
ему поддержку yasnippet"
    (if (or (not company-mode/enable-yas)
           (and (listp backend) (member 'company-yasnippet backend)))
        backend
      (append (if (consp backend)  backend (list backend))
              '(:with company-yasnippet))))


  (defun msk/add-company-backend (backend)
    "Добавляем BACKEND в список активных company-backend'ов"
    (add-to-list 'company-backends backend))


  (defun msk/add-company-backend-with-yas (backend)
    "Добавляет BACKEND в список активных backend'ов после обработки с
помощью `msk/company-backend-with-yas'"
    (msk/add-company-backend (msk/company-backend-with-yas backend))))


;; Проверка текста на лету
;; Это может быть синтаксис, или различные подсказки по коду программы
(progn
  (msk/require-pkgs 'flycheck)
  (global-flycheck-mode t))


;; Подсвечиваем лишние пробелы, пробелы в пустых
;; строках и удаляем их при сохранении
(progn
  (require 'whitespace)
  (setq whitespace-style '(face empty tabs lines-tail trailing))
  (global-whitespace-mode t)
  (add-hook 'before-save-hook 'whitespace-cleanup))


;; Перенос слишком больших строк в режиме редактирования текста
(add-hook 'text-mode-hook  #'auto-fill-mode t)


;; Классная система подскок в минебуфере для Lisp-like языков
;; После ввода очередного слова-названии функции выводит ее сигнатуру в минибуфер
(progn
  (defun turn-on-eldoc ()
    (eldoc-mode t))

  (add-hook 'emacs-lisp-mode-hook #'turn-on-eldoc-mode)
  (add-hook 'lisp-interaction-mode-hook #'turn-on-eldoc-mode))
