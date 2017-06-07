step 'ユーザーがアカウント登録済みである' do
  @user = create(:michael)

  expect(@user.activated).to be_truthy
end

step 'ログインページにアクセスする' do
  visit login_path
end

step ':title画面が表示されている' do |title|
  expect(page).to have_title(title)
end

step ':email と :password を入力する' do |email, password|
  fill_in email, with: @user.email
  fill_in password, with: @user.password
end

step ':textボタンをクリックする' do |text|
  click_button text
end

step 'ログイン後のユーザー画面を表示する' do
  expect(page).to have_title(@user.name)
end

step 'ユーザーがアカウント登録済みである' do
  @user = create(:michael)

  expect(@user.activated).to be_truthy
end

step 'ログインページにアクセスする' do
  visit login_path
end

step 'ユーザーがフォームに入力しない' do
end

step ':textボタンをクリックする' do |text|
  click_button text
end

step ':title画面にとどまり、アラートを表示し入力を促す' do |title|
  expect(page).to have_title(title)

  expect(page).to have_selector('div.alert.alert-danger', text: 'Invalid')
end
