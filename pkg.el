;; Инициализируем el-get, если не установлен, то качаем и ставим
(setq el-get-dir (msk/concat-path msk-cache-dir "el-get"))
(add-to-list 'load-path (msk/concat-path el-get-dir "el-get"))

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)
    (kill-buffer "*el-get bootstrap*")))

(require 'el-get-elpa)
(set-default 'package-user-dir
             (msk/concat-path msk-cache-dir "elpa"))

(unless (file-directory-p el-get-recipe-path-elpa)
  (el-get-elpa-build-local-recipes))

(add-to-list 'el-get-recipe-path
	     (msk/concat-path msk-dir "recipes"))
