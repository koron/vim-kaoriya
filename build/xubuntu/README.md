# for Xubuntu (may for Ubuntu also)

1. Create a package

    ```console
    $ make package-auto
    ```

2. Copy to a target machine (OPTIONAL)

    ```console
    $ scp vim90-kaoriya-ubuntu23.10-9.0.0814-20240207.tar.bz2 foobar@machine:tmp
    ```

3. Install as root

    ```console
    $ sudo tar xvf vim90-kaoriya-ubuntu23.10-9.0.0814-20221002.tar.bz2 -C /
    ```
