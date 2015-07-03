(defun msk/concat-path (path1 path2)
  "Складывает два пути и ставит между ними раделитель,
если patch1 не заканчивается на него"
  (concat (file-name-as-directory path1) path2))

(defun msk/load (file)
  "Исполняет Lisp код из FILE"
  (load file nil t nil t))


(defun msk/load-mod (module &optional path)
  "Загружает msk-mod'ы.

Модуль представляет собой директорию, содержащую файл \"main.el\".
MODULE - имя модуля, который надо загрузить.
PATH - путь до директории, в которой следует искать моуль"
  (if (null path)
      (setq path msk-mods-dir))
  (msk/load (msk/concat-path (msk/concat-path path module) "main.el")))


(defun msk/load-file-from-script-dir(file)
  "Загружает скрипт из той же директории, что и вызывающий ее скрипт"
  (msk/load
   (msk/concat-path (file-name-directory load-file-name) file)))


(defun msk/require-pkgs (packages)
  "Устанавливает и подгружает указанные пакеты или пакет"
  (if (not (listp packages))
      (setq packages (list packages)))

  (let ((new-pkgs (set-difference packages msk-active-packages)))
    (append msk-active-packages new-pkgs)
    (el-get 'sync new-pkgs)
    new-pkgs))


(defun msk/load-mods (mods-list)
  "Загружает модули перечисленные в списке

Каждый элемент списка MODS-LIST передается как параметр `msk/load-mod'"
  (mapcar (lambda (mod)
            (progn
              (apply 'msk/load-mod
                     (if (atom mod)
                         (list mod)
                       mod))))
          mods-list))


(defun msk/create-dir-if-not-exist (dir-path)
  "Создает директорию DIR-PATH, если ее не существует"
  (if (not (file-exists-p dir-path))
      (mkdir dir-path)))

(defun msk/setenv-if-not-exist (varible value)
  "Устанавливает переменную окружения для Emacs если она не объявлена или пуста"
  (if (not (getenv varible))
      (setenv varible value)))
