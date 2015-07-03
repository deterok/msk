;; `defvar' для подавления Warning'ов
(progn
  (defvar ido-context-switch-command  nil)
  (defvar ido-ubiquitous-debug-mode   nil)
  (defvar ido-cr+-enable-next-call    nil)
  (defvar ido-cr+-replace-completely  nil))

(msk/require-pkgs '(ido-ubiquitous
                    ido-vertical-mode
                    smex))

(setq inhibit-splash-screen   t    ;Забиваем сплеш начальный с инфойо Emacs

      ;; Делаем scratch buffer пустым, можно что-нибудь свое написать
      initial-scratch-message nil)

;; Убираем лишнии элементы интерфейса
(progn
  (scroll-bar-mode    -1)               ;Вырубаем полосы прокрутки
  (tool-bar-mode      -1)               ;и верхний tool-bar
  (menu-bar-mode      -1))              ;и меню верхнее

;; Изменяем mode line
;; TODO: изменить формат mode line
(progn
  (size-indication-mode t)
  (column-number-mode   t)            ;Отображаем кол-во колонок
  (display-time-mode    t)            ;Отображаем время
  (display-battery-mode t))           ;Отображаем заряд батареии


;; Настроик семантических подсказок в меню открытия файлов и поднобных
(progn
  ;: Семантическая подсказки в меню открытиия файла
  (require 'ido)

  ;; Использование ido-menu везде где только можно
  (require 'ido-ubiquitous)

  ;; Отображаем меню в вертикальном виде
  (require 'ido-vertical-mode)

  ;; Указываем файл, в который будет сохраняться история использования файлов
  (set-default 'ido-file-history
               (msk/concat-path msk-cache-dir "ido-history.dat"))

  (set-default 'ido-save-directory-list-file
               (msk/concat-path msk-cache-dir "ido.last"))

  ;;Хотим, что бы ido был менеежестким в отсеве элементов
  (set-default 'ido-enable-flex-matching t)

  ;;Улучшенное автодополнение при выборе файла и т.д.
  (ido-mode              t)

  ;;пытаемся его сделать везде!
  (ido-everywhere        t)

  ;;искать файлы в других директориях, если в текущей не найден
  (set-default 'ido-use-filename-at-point 'guess)

  ;;Подсказки выводим вертикально
  (ido-vertical-mode     t)

  ;;Везде пытаемся заменить completing-read на ido-completing-read
  (ido-ubiquitous-mode   t))


(progn
  (require 'smex)
  (set-default 'smex-save-file
               (msk/concat-path msk-cache-dir "smex-items"))

  (smex-initialize)

  ;;Подгружаем данные в кэш из предыдущего сеанса
  (defun smex-update-after-load (unused)
    (when (boundp 'smex-cache)
      (smex-update)))

  (add-hook 'after-load-functions 'smex-update-after-load)

  ;; Заменяем стандартный командный интерпритатор на smex - с
  ;; ido-подобным автодополнением
  (global-set-key (kbd "M-x") 'smex)
  (global-set-key (kbd "M-X") 'smex-major-mode-commands))

(defalias 'yes-or-no-p 'y-or-n-p) ;На вапросы Да/Нет можно отвечать одной клавишей


;; Настраваем темы оформления
(progn
  ;; Определяем директории для тем
  (defvar msk-themes-dir  (msk/concat-path msk-cache-dir "themes"))
  (msk/create-dir-if-not-exist msk-themes-dir)
  (add-to-list 'custom-theme-load-path msk-themes-dir)

  ;;Директори для тем, созданных пользователем
  (set-default 'custom-theme-directory
               (msk/concat-path msk-cache-dir "custom-themes"))

  (msk/create-dir-if-not-exist custom-theme-directory)

  ;; Активируем тему smyx и если ее нет, то загружаем и
  ;; пытаемся активировать ее еще раз
  (unless (condition-case nil
              (load-theme 'smyx t)
            (error nil))
    (progn
      (url-copy-file
       "https://raw.githubusercontent.com/tacit7/smyx/master/smyx-theme.el"
       (msk/concat-path custom-theme-directory "smyx-theme.el") t)
      (load-theme 'smyx t))))
