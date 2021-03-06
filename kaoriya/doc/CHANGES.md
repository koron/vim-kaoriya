## 2020/07/24 の変更点

*   ベースコードを8.2.1287に更新しました
*   既知の問題: 特に無し
*   テストは全て通過しました

    詳細: <https://gist.github.com/koron/1f049d065c7146a11b2689d5372d3d7b>

## 2020/07/18 の変更点

*   ベースコードを8.2.1233に更新しました
*   contrib 更新
    *   lang-ja (2020-06-25 d262bed)
    *   LuaJIT (2020-07-13 570e758ca7)
    *   vimdoc-ja (2020-07-17 4a765dca)
    *   vimproc (2020-06-23 8f40d86)
*   既知の問題
    *   以下のテストが失敗しています
        * `Test_menu`
        * `Test_System`
        * `Test_terminal_composing_unicode`
        * `Test_terminal_env`
        * `Test_terminal_noblock`
        * `Test_terminal_paste_register`
        * `Test_terminal_scrape_multibyte`
        * `Test_terminal_scrollback`
        * `Test_terminal_servername`
        * `Test_terminal_version`
        * `Test_undofile_earlier`
        * `Test_add_remove_menu`
        * `Test_click_in_other_winbar`
        * `Test_click_in_winbar`
        * `Test_redraw_after_scroll`
        * `Test_classes_re1`
        * `Test_classes_re2`

## 2020/01/06 の変更点

*   ベースコードを8.2.0087に更新しました
*   外部言語インターフェースの変更
    *   Python2.xのサポートを終了しました
*   バグ修正
    *   .vimrcでguifontを設定できなかった (#27)
    *   .vimrcでtransparencyを設定できなかった (#27)
*   contrib 更新
    *   lang-ja (2019-12-27 0828d89)
    *   vimdoc-ja (2020-01-05 b0394e06)
*   既知の問題
    *   いくつかのテストが失敗しています

## 2019/12/22 の変更点

*   ベースコードを8.2.0029に更新しました
*   +kaoriyaパッチ修正
    *   8.2.0029 への対応
    *   transparencyオプションの修正
*   外部言語インターフェースについての予告
    *   Python2に対応する最後の版となります
*   contrib 更新
    *   lang-ja (2019-12-15 284b561)
    *   LuaJIT (2019-12-21 0bee44c9dc)
    *   vimdoc-ja (2019-12-20 a91e447b)
    *   vimproc (2019-11-29 89065f6)
*   既知の問題
    *   いくつかのテストが失敗しています

## 2019/06/01 の変更点

*   ベースコードを8.1.1436に更新しました
*   +kaoriyaパッチ修正
    *   Migemo機能のバグ修正とドキュメント追加
    *   charspaceオプションの修正
*   VIMDLLを有効化しました
*   contrib 更新
    *   lang-ja (2019-05-18 6443a19)
    *   vimdoc-ja (2019-05-30 71722f86)

## 2019/03/25 の変更点

*   ベースコードを8.1.1048に更新しました
*   diff.exe の同梱をやめました
    *   `diffopt=internal` の導入に伴い不要になったため
*   XubuntuでのIMサポートを改善
*   contrib 更新
    *   vimdoc-ja (2019-03-25 01aaa549)

## 2019/03/17 の変更点

*   ベースコードを8.1.1010に更新しました
*   外部言語インターフェースの変更
    *   Perl
        *   Strawberry Perlへ変更しました
        *   Perlのバージョンを5.28.1に変更しました
    *   Ruby
        *   Rubyのバージョンを2.6.1に変更しました
        *   PATHの追加設定が必要です
    *   Python
        *   Python2のバージョンを2.7.16に変更しました
        *   Python3のバージョンを3.7.2に変更しました
*   contrib 更新
    *   autofmt (2018-07-03 641529c)
    *   lang-ja (2019-03-12 76e8776)
    *   LuaJIT (2019-01-10 f0e865dd48)
    *   vimdoc-ja (2019-03-08 6a780f2b)
    *   vimproc (2019-03-10 eb5b2b1)

## 2018/05/20 の変更点

*   ベースコードを8.1.0005に更新しました

## 2018/05/18 の変更点

*   ベースコードを8.1.0000に更新しました
*   rprichard/winpty の 0.4.3 をバンドルするようにしました
*   gvimrc を微修正しました
*   色付き絵文字に対応しました
*   universal ctags への案内に切り替えました
*   contrib 更新
    *   lang-ja (2018-05-18 ed89d1d)
    *   LuaJIT (2018-04-22 a90e7795ca)
    *   vimdoc-ja (2018-03-23 3e807ea2)
    *   vimproc (2018-01-07 2300224)

## 2017/05/02 の変更点

*   ベースコードを8.0.0596に更新しました
*   contrib 更新
    *   autofmt (2017-02-13 99f2b50)
    *   lang-ja (2017-02-16 92ba192)
    *   LuaJIT (2017-05-01 8271c643c)
    *   vimdoc-ja (2017-04-22 8d0c593d)

## 2017/01/01 の変更点

*   ベースコードを8.0.0134に更新しました
*   contrib 更新
    *   autofmt (2016-12-03 4bf8dbb)
    *   lang-ja (2016-12-08 4c3c613)
    *   LuaJIT (2016-12-30 8e5d7be)
    *   vimdoc-ja (2016-12-23 489d8a0)

## 2016/11/13 の変更点

*   ベースコードを8.0.0082に更新しました
*   diff.exe をバンドルするようにしました
*   contrib 追加
    *   diffutils (2016-11-13 4a42ca2)
*   contrib 更新
    *   LuaJIT (2016-10-20 716f2da)
    *   vimdoc-ja (2016-11-03 6b6b902)

## 2016/10/16 の変更点

*   ベースコードを8.0.0039に更新しました
*   contrib 更新
    *   lang-ja (2016-09-22 8080fc7)
    *   LuaJIT (2016-10-13 3f43f09)
    *   vimdoc-ja (2016-10-14 4a43b59)
*   既知の問題
    *   https://github.com/vim-jp/issues/issues/970

## 2016/09/13 の変更点

*   ベースコードを8.0.0003に更新しました
*   contrib 更新
    *   lang-ja (2016-09-13 57db842)
    *   vimdoc-ja (2016-09-12 da005d9)
*   過去の変更点(CHANGES.txt)を移動しました

    <https://github.com/koron/vim-kaoriya/tree/master/old/CHANGES-7.txt>
