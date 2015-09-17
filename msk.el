(print "MSK Запускается")
(load "utils" nil t nil t)

(defconst msk-version "1.2.1"
  "Версия пакета msk")

;; Объявление стандартных путей
(defvar msk-dir         (file-name-directory load-file-name)
  "Центральная директория набора")

(defvar msk-cache-dir   (msk/concat-path user-emacs-directory "cache")
  "Директория по-умолчанию для кешей, таких как файлы el-get и т.д.")

(defvar msk-mods-dir    (msk/concat-path msk-dir "mods")
  "Директория по-умолчанию для модов")

(defvar msk-mods-list  `(("core" ,msk-dir))
  "Список всех модов, которые буду активированы. Сохраняется порядок
  активации")

(defvar msk-active-packages (list)
  "Список всех модов, загруженных с помощью msk/require-pkgs")

(defvar msk-before-init-hook nil
  "Хук будет вызван до инициализации пакета msk")

(defvar msk-after-init-hook nil
  "Хук будет вызван после инициализации пакета msk")

(defun msk-init()
  "Функция инициализации пакета msk"

  (run-hooks 'msk-before-init-hook)

  ;; Создаем директорию для загружаемых файлов, вспомгательных
  ;; программ и пакетных менеджеров
  (if (not (file-exists-p msk-cache-dir))
      (mkdir msk-cache-dir))

  ;; Загружаем настройки пакетного менеджера el-get
  (msk/load  (msk/concat-path msk-dir "pkg.el"))

  ;;Запуск модулей
  (msk/load-mods msk-mods-list)

  (run-hooks 'msk-after-init-hook)

  (print "Все!  MSK запущен!")

  ;; Подчищаем за конфигуратором, переходим на буфер *scratch*
  (set-buffer "*scratch*")
  (delete-other-windows))

(provide 'msk)
