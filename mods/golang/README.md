MSK Golang support mod
======================

Preparation
-----------

#### Init ####

If emacs launched not in terminal, godef will be not found.
The following code should fix it, but it needs to adjust for themselves:
```elisp
(msk/setenv-if-not-exist "GOPATH"
                         (msk/concat-path (file-truename "~/")
                                          ".local/lib/go/"))
(setenv "PATH"
        (concat (getenv "PATH") ":"
        (msk/concat-path (getenv "GOPATH") "bin")))

(add-to-list 'exec-path (msk/concat-path (getenv "GOPATH") "bin"))

```

Just add it to initi.el after `(require 'msk)`.


#### Gocode  configuration ####

For information read https://github.com/nsf/gocode#options

Fast configuration:

        $ gocode set propose-builtins true
        $ gocode set autobuild true
