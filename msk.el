(print "MSK Запускается")
(load "utils" nil t nil t)

(defconst msk-version "1.0.0"
  "Версия пакета msk")

;; Объявление стандартных путей
(defvar msk-dir         (file-name-directory load-file-name)
  "Центральная директория набора")

(defvar msk-cache-dir   (msk/concat-path user-emacs-directory "cache")
  "Директория по-умолчанию для кешей, таких как файлы el-get и т.д.")

(defvar msk-mods-dir    (msk/concat-path msk-dir "mods")
  "Директория по-умолчанию для модов")

(defvar msk-mods-list  `(("base" ,msk-dir))
  "Список всех модов, которые буду активированы. Сохраняется порядок
  активации")

(defvar msk-active-packages (list))

(if (not (file-exists-p msk-cache-dir))
    (mkdir msk-cache-dir))

(msk/load-file-from-script-dir "pkg.el")

;;Запуск модулей
(msk/load-mods msk-mods-list)

(print "Все!  MSK запущен!")

(set-buffer "*scratch*")
(delete-other-windows)
(provide 'msk)
