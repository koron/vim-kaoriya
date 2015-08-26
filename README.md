## How to Setup

1. Install [git for windows](https://github.com/git-for-windows/git/releases)
2. Install [guilt](https://github.com/koron/guilt)

    ```
    $ git clone https://github.com/koron/guilt.git
    $ cd guilt
    $ make install
    ```

3. Checkout [vim-kaoriya](https://github.com/koron/vim-kaoriya) and 

    ```
    $ git clone https://github.com/koron/vim-kaoriya.git
    $ cd vim-kaoriya
    $ git submodule init
    $ git submodule update
    ```

4. Setup `guilt.patchesdir` to apply **kaoriya** patches.

    ```
    $ cd vim-kaoriya/vim
    $ git checkout master
    $ git config guilt.patchesdir ../patches
    ```

