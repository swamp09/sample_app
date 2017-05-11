前提(/^ユーザーがログイン済みである$/) do
  @user = FactoryGirl.create(:michael)

  visit login_path

  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password

  click_button 'Log in'

  expect(page).to have_title(@user.name)
end

もし(/^ログアウトリンクからログアウトする$/) do
  click_link 'Log out'
end

ならば(/^ログアウトし、Homeに遷移する/) do
  expect(page).to have_title('Home')
end
