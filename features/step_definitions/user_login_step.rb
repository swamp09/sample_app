前提(/^ユーザーがアカウントを登録済みである$/) do
  @user = FactoryGirl.create(:michael)
  visit login_path
end

もし(/^ユーザーログイン画面からフォームにアカウント情報を入力する、ログインボタンをクリック$/) do
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password

  click_button 'Log in'
end

ならば(/^ログイン後のユーザープロファイル画面に遷移すること/) do
  expect(page).to have_title(@user.name)
end

前提(/^ユーザーがフォームに入力しない$/) do
  visit login_path
end

もし(/^ユーザーログイン画面からログインボタンをクリック$/) do
  click_button 'Log in'
end

ならば(/^ログイン画面にとどまり、アラートを表示し入力を促す/) do
  expect(page).to have_title('Log in | Ruby on Rails Tutorial Sample App')

  expect(page).to have_selector('div.alert.alert-danger', text: 'Invalid')
end
