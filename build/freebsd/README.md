# for FreeBSD

1. Create a package

    ```console
    $ make package-auto
    ```

2. Copy to a target machine (OPTIONAL)

    ```console
    $ scp vim90-kaoriya-freebsd13-9.0.0814-20221002.tar.bz2 foobar@machine:tmp
    ```

3. Install as root

    ```console
    $ sudo tar xvf vim90-kaoriya-freebsd13-9.0.0814-20221002.tar.bz2 -C /
    ```
