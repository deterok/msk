(msk/require-pkgs 'pretty-mode-plus)

(require 'pretty-mode)
(global-pretty-mode t)

;; Автосохранение в директорию $TMPDIR/emacs$UID/
(progn
  (defconst emacs-tmp-dir (format "%s/%s%s/" temporary-file-directory
                                  "emacs" (user-uid)))
  (setq backup-directory-alist
        `((".*" . ,emacs-tmp-dir)))
  (setq auto-save-file-name-transforms
        `((".*" ,emacs-tmp-dir t)))
  (setq auto-save-list-file-prefix
        emacs-tmp-dir))
