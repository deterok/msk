My Starter Kit
==============
MSK - starter kit for emacs with my preferences

Features
-------
- Hmm... my preference in settings :)
- The rudiment of the simple modular system
- Easy to install
- Russian comments in the code...

Requirements
------
- Emacs-24.4
- Git

Installation
-------
Installation is simple:

1. Clone MSK git-repository in your Emacs config dir

        $ cd ~/.emacs.d
        $ git clone https://github.com/deterok/msk.git msk

2. Add the following code in the emacs init file (usually ~/.emacs.d/init.el)

        (add-to-list 'load-path "~/.emacs.d/msk/")
        (require 'msk)

3. Rerun emacs (Maybe a few times. There may be problems with the hash-sums.
I am in the process of finding solutions)

Recomendation
------------
Read the code. Try to understand it. Change it! This is very simple!

Please send me your changes. I'll be interested to see your improvements.

Known issues
------------
#####go-mode
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