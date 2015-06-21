(defun msk/concat-path (path1 path2)
  (concat (file-name-as-directory path1) path2))

(defun msk/load (filename)
  (load filename nil t nil t))

(defun msk/load-mod (module &optional path)
  (if (null path)
      (setq path msk-mods-dir))
  (msk/load (msk/concat-path (msk/concat-path path module) "main.el")))

(defun msk/load-file-from-script-dir(file)
  (msk/load
   (msk/concat-path (file-name-directory load-file-name) file)))

(defun msk/require-pkgs (packages)
  (if (not (listp packages))
      (setq packages (list packages)))

  (let ((new-pkgs (set-difference packages msk-active-packages)))
    (append msk-active-packages new-pkgs)
    (el-get 'sync new-pkgs)
    new-pkgs))

(defun msk/load-mods (mods-list)
  (mapcar (lambda (mod)
            (progn
              (apply 'msk/load-mod
                     (if (atom mod)
                         (list mod)
                       mod
                       ))))
          mods-list))

(defun msk/create-dir-if-not-exist (dir-path)
  (if (not (file-exists-p dir-path))
      (mkdir dir-path)))

(defun msk/setenv-if-not-exist (varible value)
  (if (not (getenv varible))
      (setenv varible value)))
