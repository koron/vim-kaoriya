# ライセンス

UCRT64 版の Vim +kaoriya バイナリは、いくつかのラリブラリとスタティックリンク
してビルドしています。そのため全体としてのライセンスはGPLv3相当になります。

## ライセンス一覧

利用している各プロジェクトの個別のライセンスは以下の通りです。

| Library | Fle               | Type             |
|---------|-------------------|------------------|
|Vim      |../origdoc/LICENSE | Vim License      |
|libiconv | libiconv.txt      | GPLv3            |
|gettext  | gettext.txt       | GPLv3            |
|xpm-nox  | xpm-nox.txt       | MIT/X11          |

## About the source

本ディストリビューションの元になったソースコード及びビルド方法は以下で取得でき
ます。

- <https://github.com/koron/vim-kaoriya> - ビルドシステム一式
- <https://github.com/koron/vim-kaoriya-patches> - 適用しているパッチ
- <https://github.com/vim/vim> - Vim 本体
- MSYS2 由来のライブラリ
    - <https://packages.msys2.org/base/mingw-w64-libiconv>
    - <https://packages.msys2.org/base/mingw-w64-gettext>
    - <https://packages.msys2.org/base/mingw-w64-xpm-nox>
