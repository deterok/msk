(msk/require-pkgs '(rust-mode
                    s
                    racer-mode
                    flycheck-rust))

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)

(eval-after-load 'flycheck
     '(add-hook 'flycheck-mode-hook #'flycheck-rust-setup))
