# language: ja

機能: ログアウト機能
ログインしているユーザーが、ログアウトする

@logout
シナリオ: ログインしているユーザーがログアウトする
  ユーザーとして、
  アプリケーションからログアウトしたい

  前提 ユーザーがログイン済みである
  もし ログアウトリンクからログアウトする
  ならば ログアウトし、Homeに遷移する
