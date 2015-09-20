MSK Rust support mod
====================

Preparation
-----------

1. Donwload and install racer from here: https://github.com/phildawes/racer
2. Append exec path. Example:

        (add-to-list 'exec-path (msk/concat-path (file-truename "~/")
                                                 ".local/bin"))
3. Set rust sources path varible. Example:

        (msk/setenv-if-not-exist "RUST_SRC_PATH"
                                 (expand-file-name "~/.local/src/rustc-1.2.0/src/"))
