(msk/require-pkgs '(go-mode
                    go-company))

(progn
  (require 'go-mode)
  (require 'company-go)
  (msk/add-company-backend 'company-go))


(defun go ()
  "run current buffer"
  (interactive)
  (compile (concat "go run \"" (buffer-file-name) "\"")))


(defun go-build ()
  "build current buffer"
  (interactive)
  (compile (concat "go build  \"" (buffer-file-name) "\"")))


(defun go-build-dir ()
  "build current directory"
  (interactive)
  (compile "go build ."))


(defun go-fix-buffer ()
  "run gofix on current buffer"
  (interactive)
  (show-all)
  (shell-command-on-region (point-min) (point-max) "go tool fix -diff"))


(defun go-install-package ()
  "install package"
  (interactive)
  (let
      ((pkg (read-from-minibuffer "Install package: " nil nil nil 'hook-go-pkg)))
    (if (not (string= pkg ""))
        (compile (concat "go install \"" pkg "\"")))))


(defun go-test-package ()
  "test package"
  (interactive)
  (let
      ((pkg (read-from-minibuffer "Test package: " nil nil nil 'hook-go-pkg)))
    (if (not (string= pkg ""))
        (compile (concat "go test \"" pkg "\"")))))


(progn
  (define-key go-mode-map (kbd "C-c C-r")   'go-remove-unused-imports)
  (define-key go-mode-map (kbd "C-c C-c")   'go)
  (define-key go-mode-map (kbd "C-c C-f")   'gofmt)
  (define-key go-mode-map (kbd "C-c C-S-f") 'go-fix-buffer)
  (define-key go-mode-map (kbd "C-c C-d")   'godoc)
  (define-key go-mode-map (kbd "C-c C-a")   'go-import-add)
  (define-key go-mode-map (kbd "C-c i")     'go-install-package)
  (define-key go-mode-map (kbd "C-c C-t")   'go-test-package)
  (define-key go-mode-map (kbd "M-.")       'godef-jump)
  (define-key go-mode-map (kbd "C-M-.")     'godef-jump-other-window)
  (define-key go-mode-map (kbd "C-k")       'go-kill))
