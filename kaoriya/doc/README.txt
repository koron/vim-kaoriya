                   Vim version 9.1 香り屋版 導入マニュアル

                                                         Version: 1.11.0
                                                          Author: MURAOKA Taro
                                                           Since: 23-Aug-1999
                                                     Last Change: 14-Dec-2025.

概要
  Vimはviクローンに分類されるテキストエディタです。

  オリジナルのVimはhttps://www.vim.org/で公開されており、そのままでも日本語を含
  むテキストは編集できますが、香り屋では日本語をより扱い易くするための修正と追
  加を行い香り屋版として公開しています。

  香り屋版は64ビット版のみが提供されます。Windowsの32ビット版自体のサポートが
  終了しています。

インストール方法
  配布ファイルはZIP書庫です。配布ファイルにはVimプログラムフォルダが格納されて
  いるので、解凍してシステム内の好きな場所に配置してください。

  64ビット版
    配布ファイル: vim91-kaoriya-win64-V.V.V-YYYYMMDD.zip
    Vimプログラムフォルダ: vim91-kaoriya-win64

  上記のV.V.VにはベースとなったVimのバージョンがパッチ番号まで含めて入ります。
  上記のYYYYMMDDにはリリースの年月日が入ります。

実行方法
  Vimプログラムフォルダの中のgvimもしくはvimをダブルクリックしてください。

アンインストール (Windows)
  Vimプログラムフォルダを削除してください。特別な操作は不要です。

初心者の方へ
  まずはVimの操作に慣れるためトレーニングすることをオススメします。1回のトレー
  ニングにかかる時間には個人差がありますが30分から1時間くらいです。トレーニン
  グを開始するにはVimを起動した後

    :Tutorial

  と入力してリターンキーを押します。あとは画面に表示された文章にしたがって操作
  することで、Vimの基本的な操作を練習することができます。慣れるまで何度か繰り
  返し練習するとより効果的です。

Vimの拡張機能について
  本章ではVimの拡張機能の紹介とインストール方法について述べます。拡張機能をイ
  ンストールしなくても、Vimを使うことはできます。

  ctagsについて
    現在のVimはctagsを同梱していません。必要とする方は以下のサイトから各自入手
    しインストールしてください。

    - Universal Ctags
        https://ctags.io/

    - Windows 版ダウンロード
        https://github.com/universal-ctags/ctags-win32/releases

  Luaとの連携
    KaoriYa版にはLua (LuaJIT)がバンドルされているので、Luaインターフェースは自
    動的に有効になります。Luaインターフェースの詳細については":help lua"として
    Vim付属のマニュアルを参照してください。

    - LuaJIT サイト
        http://luajit.org/

使用許諾
  香り屋版のライセンスはオリジナルのVimに従います。詳しくはorigdoc/README.txt
  をご覧下さい。

  Vimはチャリティーウェアと称していますが、オープンソースであり無料で使用する
  ことができます。しかしVimの利用に際して対価を支払いたいと考えたのならば、是
  非ウガンダの孤児達を援助するための寄付をお願いいたします。

  Vim開発スポンサー制度
    Vim開発スポンサー制度と機能要望投票制度が始まりました。有志がVimの開発にお
    金を出資しVimの開発へ専念してもらおうという主旨です。出資者には見返りに機
    能要望投票の権利が与えられます。最近ではfoldingがそうであったように、この
    機能要望投票で多くの票数を集めた機能から優先して実装されます。出資は1口10
    ユーロ以上からで、PayPalを通じてクレジットカードによる決済も可能です。また
    寄付した事実が公表されることを拒まなければ、100ユーロ以上寄付をした場合に
    は「Hall of honour」に掲載されます。詳細は以下のURLを参照してください。

    - Sponsor Vim development
      https://www.vim.org/sponsor/index.php

オリジナルとの相違点
  ソース差分
    patchフォルダ内に差分を同梱しています。差分の使い方や内容に関する質問やコ
    メントなどありましたら香り屋版メンテナまで連絡ください。ソース1行1行に至る
    までの検証も大歓迎します。

    以下のレポジトリでは同パッチの最新版を公開しています。

    - vim-kaoriya-patches: +kaoriyaパッチ
      https://github.com/koron/vim-kaoriya-patches

    patchフォルダ及びvim-kaoriya-patches内の名前がXで始まるパッチは非常に実験
    的なものであり公開版には適用されていません。興味のある方だけ御覧ください。

  gitによるソースとパッチの入手方法
    香り屋版のソースコード(及びパッチ)をgithubレポジトリから取得するには以下の
    サイトを参考にしてください。

    - vim-kaoriya: ビルド用スクリプト他
      https://github.com/koron/vim-kaoriya

既知の問題点
  * qkcの-njフラグでコンバートしたJISファイルは開けない(GNU iconv)
  * scrolloffが窓高の丁度半分の時、下へのスクロールが2行単位になる

質問・連絡先
  日本のVimユーザ向けのGoogleグループ(vim_jp)が用意されています。どんなに簡単
  なことでもわからないことがあるのならばここで聞いてみると良いでしょう。きっと
  何らかの助けにはなるはずです。

    https://groups.google.com/group/vim_jp/?hl=ja

  もちろんメールで香り屋版メンテナに直接聞いてもらっても構いません。日本語化部
  分などの不都合は香り屋版メンテナまで連絡をいただければ、折をみて修正いたしま
  す。
  
  Vim本体に属すると思われる不都合については、直接Vim本家のほうへ英語で連絡する
  か、香り屋版メンテナに問い合わせてください。応急的に処置できるものであればそ
  うしますし、そうでなくても後日つたない英語になりますがVim本家へフィードバッ
  クできるかもしれません。Vim日本語版等の関連情報は次のURLにあります。

  - Vim本家
      https://www.vim.org/
      https://github.com/vim/vim
  - Vimの日本コミュニティvim-jp
      https://vim-jp.org/
      https://vim-jp.org/docs/chat.html (チャット/Slack)
      https://github.com/vim-jp/issues/issues (バグ報告、機能要望)
  - vim_jp Google グループ
      https://groups.google.com/group/vim_jp/?hl=ja
  - 日本語ドキュメント
      https://github.com/vim-jp/vimdoc-ja/
      https://github.com/vim-jp/vimdoc-ja-working/
      https://github.com/vim-jp/lang-ja/
  - 香り屋版メンテナ
      https://github.com/koron/vim-kaoriya/
      MURAOKA Taro <koron.kaoriya@gmail.com>
      X/Twitter @kaoriya

謝辞
  何よりも、素晴らしいエディタであるVimをフリーソフトウェアとして作成、公開
  し、日本語版の公開を快諾していただいたBram Moolenaar氏に最大の感謝をいたしま
  す。また、この配布パッケージには以下の方々によるファイル・ドキュメントが含ま
  れています。加えて香り屋版の作成に関連して、多くの方々から様々なアイデアやバ
  グ報告をいただきました。皆様協力ありがとうございます。

  (アルファベット順)
  - 215 (Vim掲示板:1587)
    autodate.vimの英語ドキュメント添削
  - FUJITA Yasuhiro <yasuhiroff@ka.baynet.ne.jp>
    runtime/keymap/tcode_cp932.vim (マップ修正・追加)
  - KIHARA, Hideto <deton@m1.interq.or.jp>
    runtime/keymap/tutcode_cp932.vim
  - MATSUMOTO Yasuhiro <mattn_jp@hotmail.com>
    diffs/ (一部コード流用/アドバイス/遊び仲間)
    googletranslate.vim
  - NAKADAIRA Yukihiro <http://code.google.com/u/yukihiro.nakadaira/>
    plugins/autofmt
  - NISHIOKA Takuhiro <takuhiro@super.win.ne.jp>
    runtime/plugin/format.vim (Vim6対応改造版)
  - TAKASUKA Yoshihiro <tesuri@d1.dion.ne.jp>
    runtime/keymap/tcode_cp932.vim

  そして総てのVimユーザに。

------------------------------------------------------------------------------
                  生きる事への強い意志が同時に自分と異なる生命をも尊ぶ心となる
                                        MURAOKA Taro <koron.kaoriya@gmail.com>
 vim:set ts=8 sts=2 sw=2 tw=78 et ft=memo:
