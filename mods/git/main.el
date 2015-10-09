(msk/require-pkgs '(magit
                    magit-filenotify))

(add-hook 'magit-status-mode-hook #'magit-filenotify-mode)
(global-magit-file-mode)
