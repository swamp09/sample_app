# language: ja

機能: マイクロポスト作成、削除機能

  シナリオ: ログインしているユーザーがマイクロポストを作成する
    前提 ユーザーがログイン済み
    もし マイクロポストを入力し、Postボタンを押す
    ならば DBに反映され作成される

  シナリオ: ログインしているユーザーがマイクロポストを削除する
    前提 ユーザーがログイン済み
    もし deleteリンクが表示されている
    ならば deleteリンクをクリックし、DBに反映され削除される
