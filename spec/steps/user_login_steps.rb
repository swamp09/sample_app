# encoding: utf-8

step 'ユーザーがアカウント登録済みである' do
  @user = create(:michael)

  expect(@user.activated).to be_truthy
end

step 'ログインページにアクセスする' do
  visit login_path
end

step 'ログイン画面が表示されている' do
  expect(page).to have_title('Log in | Ruby on Rails Tutorial Sample App')
end

step 'email と password を入力する' do
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password
end

step 'ログインボタンをクリックする' do
  click_button 'Log in'
end

step 'ログイン後のユーザー画面を表示する' do
  expect(page).to have_title(@user.name)
end

#####################

step 'ユーザーがアカウント登録済みである' do
  @user = create(:michael)

  expect(@user.activated).to be_truthy
end

step 'ログインページにアクセスする' do
  visit login_path
end

step 'ユーザーがフォームに入力しない' do
end

step 'ログインボタンをクリックする' do
  click_button 'Log in'
end

step 'ログイン画面にとどまり、アラートを表示し入力を促す' do
  expect(page).to have_title('Log in | Ruby on Rails Tutorial Sample App')

  expect(page).to have_selector('div.alert.alert-danger', text: 'Invalid')
end
