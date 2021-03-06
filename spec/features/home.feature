# language: ja

機能: ホーム画面
@javascript
  シナリオ: マイクロポストを投稿する
    前提 ユーザーがログイン済みである
    もし ホーム画面に訪問する
    かつ "micropost_content"フォームに"Just do it"と入力する
    かつ "Post"ボタンをクリックする
    ならば "Just do it"が新しくfeedに追加されている

  シナリオ: ホーム画面でユーザーごとのマイクロポストを表示する
    前提 ユーザーがログイン済みである
    かつ マイクロポストを投稿済みである
    もし ホーム画面に訪問する
    ならば マイクロポスト一覧を表示する

  シナリオ: ホーム画面でマイクロポストを検索する
    前提 ユーザーがログイン済みである
    かつ マイクロポストを投稿済みである
    もし ホーム画面に訪問する
    かつ "search"フォームに"orange"と入力する
    かつ "Search"ボタンをクリックする
    ならば "orange"に一致するマイクロポストを表示する
    かつ 検索に一致しないものは表示していない

  シナリオ: リプライを投稿する
    前提 ユーザーがログイン済みである
    もし ホーム画面に訪問する
    かつ "micropost_content"フォームに"@archer hello,archer"と入力する
    かつ "Post"ボタンをクリックする
    ならば "@archer hello,archer"が新しくfeedに追加されている
    かつ archerがログインする
    かつ ホーム画面に訪問する
    ならば "@archer hello,archer"がfeedに表示されている

  シナリオ: リプライでオートコンプリートを使う
    前提 ユーザーがログイン済みである
    もし ホーム画面に訪問する
    かつ "micropost_content"フォームに"@ar"と入力し、オートコンプリートを選択する
    かつ "Post"ボタンをクリックする
    ならば "@archer"が新しくfeedに追加されている
