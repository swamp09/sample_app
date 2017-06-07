# language: ja

機能: ユーザー一覧、検索機能
  シナリオ: ログインしているユーザーがユーザー一覧を表示する
    前提 ユーザーがログイン済みである,他のユーザーが３０人いる
    もし ユーザー一覧ページに訪問する
    ならば ユーザー一覧を表示する

  シナリオ: ユーザーを検索する
    前提 ユーザーがログイン済みである,他のユーザーが３０人いる
    もし ユーザー一覧ページに訪問する
    ならば ユーザー一覧を表示する
    かつ 検索フォーム"search"に"Archer"と入力する
    かつ "Search"ボタンをクリックする
    ならば 検索したユーザー"Archer"を表示する
