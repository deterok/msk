(msk/require-pkgs '(rust-mode
                    racer-mode))

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
