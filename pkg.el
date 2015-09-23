;; Инициализируем el-get, если не установлен, то качаем и ставим
(setq el-get-dir (msk/concat-path msk-cache-dir "el-get"))
(add-to-list 'load-path (msk/concat-path el-get-dir "el-get"))

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)
    (kill-buffer "*el-get bootstrap*")
    (el-get-elpa-build-local-recipes)))

;; Указываем директори для загружаемы данных и рецептов el-get
(add-to-list 'el-get-recipe-path (msk/concat-path msk-dir "recipes"))

;; Учим el-get работать с репозиториями elpa
(require 'el-get-elpa)

;; Указываем куда надо сохранять данные репозиториев elpa
(set-default 'package-user-dir
             (msk/concat-path msk-cache-dir "elpa"))

;; Создаем рецепты для elpa-репозитория
(unless (file-directory-p el-get-recipe-path-elpa)
  (el-get-elpa-build-local-recipes))

;; Добавляем рецепты необходимые для работы msk
(add-to-list 'el-get-recipe-path
	     (msk/concat-path msk-dir "recipes"))
