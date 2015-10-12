(msk/require-pkgs '(magit
                    magit-filenotify))

(add-hook 'magit-status-mode-hook #'magit-filenotify-mode)
(global-magit-file-mode)

(magit-log-arguments
    '("--graph" "--color" "--decorate" "--show-signature"))

(progn
  (global-set-key (kbd "<f6>") 'magit-status)
  (global-set-key (kbd "<f7>") 'magit-dispatch-popup))
