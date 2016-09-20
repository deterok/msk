WARNING
=======
I switched to using [Spacemacs](https://github.com/syl20bnr/spacemacs). It meets all my needs and I see no reason to continue the project.

My Starter Kit
==============
MSK - starter kit for emacs with my preferences

Features
--------
- Hmm... my preference in settings :)
- The rudiment of the simple modular system
- Easy to install
- Russian comments in the code...

Requirements
-----------
- Emacs-24.4
- Git
- Some software for some mods (See the README for a particular mode)

Installation
------------
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
-------------
Read the code. Try to understand it. Change it! This is very simple!

Please send me your changes. I'll be interested to see your
improvements.

See active [issues](https://github.com/deterok/msk/issues) and
[milestones](https://github.com/deterok/msk/milestones) to monitor the
development of the project.
