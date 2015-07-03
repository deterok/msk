(msk/require-pkgs 's)
(msk/require-pkgs 'racket-mode)

;; Поддержка юникод в repl
(add-hook 'racket-mode-hook      #'racket-unicode-input-method-enable)
(add-hook 'racket-repl-mode-hook #'racket-unicode-input-method-enable)
