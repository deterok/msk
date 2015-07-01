(msk/require-pkgs '(go-mode
                    go-company
                    go-oracle
                    go-test))

(progn
  (require 'go-mode)
  (require 'company-go)
  (require 'gotest)

  (msk/add-company-backend 'company-go)

  (add-hook 'before-save-hook (lambda ()
                                (when (eq major-mode 'go-mode)
                                  (gofmt)))))


(defun go-build-get-programm (args)
  "Возвращает команду для запуска \"go build\".
`ARGS' передается как паремтры \"go build\"."
  (s-concat go-command " build " args))


(defun go-install-get-programm (args)
  "Возвращает команду для запуска \"go install\".
`ARGS' передается как паремтры \"go install\"."
  (s-concat go-command " install " args))


(defun go-run-current-project ()
  "Запуск \"go run\" со всеми go-файлами (*.go) в текущей директории"
  (interactive)
  (add-hook 'compilation-start-hook 'go-test-compilation-hook)
  (compile (go-run-get-program "*.go"))
  (remove-hook 'compilation-start-hook 'go-test-compilation-hook))


(defun go-build ()
  "Собирает текущий буффер в бинарник.

Для подробностей смотри \"go build --help\"."
  (interactive)
  (add-hook 'compilation-start-hook 'go-test-compilation-hook)
  (compile (go-build-get-programm buffer-file-name))
  (remove-hook 'compilation-start-hook 'go-test-compilation-hook))


(defun go-build-current-project (&optional output-path)
  "Запускает \"go build\" на текущей директории.

`output-path' устанавливает путь и имя выходного файла.
Для подробностей смотри \"go build --help\"."
  (interactive)
  (add-hook 'compilation-start-hook 'go-test-compilation-hook)
  (let ((args "./..."))
    (when output-path
      (setq args (s-concat args " -o " output-path)))
    (compile (go-build-get-programm args)))
  (remove-hook 'compilation-start-hook 'go-test-compilation-hook))


(defun go-fix-buffer ()
  "Запускает \"go tool fix -diff\" на текущем буффере"
  (interactive)
  (show-all)
  (shell-command-on-region (point-min) (point-max) "go tool fix -diff"))


(defun go-install ()
  "Устанавливает go-пакет"
  (interactive)
  (let
      ((pkg (read-from-minibuffer
             "Имя устанавливаемого пакета: " nil nil nil 'hook-go-pkg)))
    (if (not (string= pkg ""))
        (compile (s-concat (go-install-get-programm) pkg )))))


;; Многие комбинации объявлены в сторонних модулях.
;; Например  комбинации `go-oracle' привязаны в основном к \"C-c C-o\"
(progn
  (define-key go-mode-map (kbd "C-c C-a")   'go-import-add)
  (define-key go-mode-map (kbd "C-c C-r")   'go-remove-unused-imports)
  (define-key go-mode-map (kbd "C-c C-c")   'go-run-current-project)
  (define-key go-mode-map (kbd "C-c C-S-c") 'go-run)
  (define-key go-mode-map (kbd "C-c C-b")   'go-build-current-project)
  (define-key go-mode-map (kbd "C-c C-S-b") 'go-build)
  (define-key go-mode-map (kbd "C-c C-f")   'gofmt)
  (define-key go-mode-map (kbd "C-c C-S-f") 'go-fix-buffer)
  (define-key go-mode-map (kbd "C-c C-d")   'godoc)
  (define-key go-mode-map (kbd "C-c i")     'go-install)
  (define-key go-mode-map (kbd "C-c C-t")   'go-test-current-project)
  (define-key go-mode-map (kbd "M-.")       'godef-jump)
  (define-key go-mode-map (kbd "C-M-.")     'godef-jump-other-window)
  (define-key go-mode-map (kbd "C-k")       'go-kill))
