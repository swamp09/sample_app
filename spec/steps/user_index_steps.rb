step 'ユーザーがログイン済みである,他のユーザーが３０人いる' do
  @user = create(:michael)
  create_list(:user, 30)

  visit login_path

  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password

  click_button 'Log in'

  visit root_path
end

step 'ユーザー一覧ページに訪問する' do
  visit users_path

  expect(page).to have_title('All users')
end

step 'ユーザー一覧を表示する' do
  User.page(1).each do |user|
    expect(page).to have_selector('li>a', text: user.name)
  end
end

step 'ユーザーがログイン済みである,他のユーザーが３０人いる' do
  @user = create(:michael)
  create(:archer)
  create_list(:user, 30)

  visit login_path

  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password

  click_button 'Log in'

  visit root_path
end

step 'ユーザー一覧ページに訪問する' do
  visit users_path

  expect(page).to have_title('All users')
end

step '検索フォーム:fieldに:valueと入力する' do |field, value|
  fill_in field, with: value
end

step ':textボタンをクリックする' do |text|
  click_button text
end

step '検索したユーザー:textを表示する' do |text|
  expect(page).to have_selector('li>a', text: text)

  expect(page).to have_title('Search result')
end
