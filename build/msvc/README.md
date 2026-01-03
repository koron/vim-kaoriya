## 主なターゲット

*   `archive` ビルドとzip作成
*   `archive-dist` zip作成

## デバッグに便利なターゲット

*   `gvimd-build` デバッグ版gvimのビルド
*   `gvimd-clean` デバッグ版gvimのクリーン
*   `vimd-build` デバッグ版gvimのビルド
*   `vimd-clean` デバッグ版gvimのクリーン

## テストリリース時のコマンド

TODO: 古いので書き直し

*   `11-build-all.bat` リリース用の32bitと64bit版のzipを作成するバッチ
*   `12-upload-all.bat` テスト配信用サーバへzipアップロードする
*   `13-update-canary.bat` canary 版を更新する
*   `14-update-develop.bat` develop 版を更新する

## 本リリース時には

1.  https://www.virustotal.com/ で配布URL & zip ファイルを検査
2.  koron/vim-kaoriya にタグを追加し、release を作成し zip を追加して公開

## テストの実行方法

```
nmake rebuild-vim
nmake vim-test
nmake gvim-test
```
