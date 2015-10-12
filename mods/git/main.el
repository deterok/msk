(msk/require-pkgs '(magit
                    magit-filenotify))

(add-hook 'magit-status-mode-hook #'magit-filenotify-mode)
(global-magit-file-mode)

(magit-log-arguments
    '("--graph" "--color" "--decorate" "--show-signature"))

(defcustom magit-reset-arguments nil
  "The arguments used when resetting."
  :group 'magit-commands
  :type '(repeat (string :tag "Argument")))


(defun magit-reset-popup (&optional arg)
  "Popup console for reset commands."
  (interactive "P")
  (--if-let (magit-commit-message-buffer)
      (switch-to-buffer it)
    (magit-invoke-popup 'magit-reset-popup nil arg)))

(defvar magit-reset-popup
  '(:varible magit-reset-arguments
    :man-page "git-reset"
    :actions ((?x "Reset"       magit-reset-index)
              (?m "Mixed reset" magit-reset)
              (?s "Soft reset"  magit-reset-soft)
              (?H "Hard reset"  magit-reset-hard))
    :max-action-columns 4
    :default-action magit-reset))

(progn
  (global-set-key (kbd "<f6>") 'magit-status)
  (global-set-key (kbd "<f7>") 'magit-dispatch-popup))

(progn
  (magit-define-popup-action 'magit-dispatch-popup
    ?x "Reset" 'magit-reset-popup ?!)

  (magit-define-popup-switch 'magit-commit-popup
    ?S "Sign using default gpg" "-S")

  (magit-define-popup-switch 'magit-merge-popup
    ?S "Sign using default gpg" "-S")

  (magit-define-popup-option 'magit-merge-popup
    ?S "Sign using gpg" "--gpg-sign="  #'magit-read-gpg-secret-key))
