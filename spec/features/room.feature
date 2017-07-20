# language: ja

機能: メッセージルーム機能
  シナリオ: ルーム一覧表示
    前提 ユーザーがログイン済みである、ルームが作成されている
    もし ルーム一覧画面に訪問する
    ならば ルームの一覧が表示されている

  シナリオ: ルームを作成しようとするが、招待したユーザーが存在しない
    前提 ユーザーがログイン済みである
    もし ルーム一覧画面に訪問する
    ならば "nickname"フォームに"@swampman"と入力する
    かつ "Follow user invite!"をクリックする
    ならば "ユーザーが見つかりません"と出力される

  シナリオ: ルームを作成しようとするが、招待しようとしたユーザーと相互フォローしていない
    前提 ユーザーがログイン済みである
    もし ルーム一覧画面に訪問する
    ならば "nickname"フォームに"@archer"と入力する
    かつ "Follow user invite!"をクリックする
    ならば "相互フォロワーのみ使えます"と出力される

  シナリオ: ルームを作成する
    前提 ユーザーがログイン済みである,ユーザーと"archer"は相互フォロー済みである
    もし ルーム一覧画面に訪問する
    ならば "nickname"フォームに"@archer"と入力する
    かつ "Follow user invite!"をクリックする
    ならば 作られたルームに遷移している

  シナリオ: ルームを表示する
    前提 ユーザーがログイン済みである、ルームが作成されている
    もし ルーム一覧画面に訪問する
    ならば ルームの一覧が表示されている
    かつ ルームを選択する
    ならば ルームを表示する