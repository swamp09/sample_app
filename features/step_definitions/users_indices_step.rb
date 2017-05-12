前提(/^ユーザーがログイン済みである、他のユーザーが３０人いる、管理者ユーザーではない$/) do
  @user = FactoryGirl.create(:archer)

  30.times { FactoryGirl.create(:user) }

  visit login_path

  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password

  click_button 'Log in'
end

もし(/^ユーザー一覧画面に訪問した、deleteリンクは表示されない$/) do
  visit users_path

  expect(page).to have_title('All users')

  expect(page).to_not have_content('delete')
end

ならば(/^ユーザー一覧を表示する/) do
  User.page(1).each do |user|
    expect(page).to have_selector('li>a', text: user.name)
  end
end

前提(/^ログイン済みユーザーが管理者である、他のユーザーが３０人いる$/) do
  @admin = FactoryGirl.create(:michael)

  return nill unless @admin.admin?

  @user = FactoryGirl.create(:user)

  visit login_path

  fill_in 'Email', with: @admin.email
  fill_in 'Password', with: @admin.password

  click_button 'Log in'
end

もし(/^ユーザー一覧画面に訪問した、ユーザー一覧にdeleteリンクが表示されている$/) do
  visit users_path

  expect(page).to have_title('All users')

  expect(page).to have_content('delete')
end

ならば(/^ユーザーを削除する/) do
  expect { click_link('delete') }.to change(User, :count).by(-1)
end
