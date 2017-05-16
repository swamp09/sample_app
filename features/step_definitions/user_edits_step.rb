前提(/^ユーザーがログイン済みで、ユーザー編集画面に訪問した$/) do
  @user = FactoryGirl.create(:michael)

  visit login_path

  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password

  click_button 'Log in'

  visit edit_user_path(@user)
end

もし(/^入力したpasswordとpassword_confirmationが一致しなかった$/) do
  expect(page).to have_title('Edit user')

  fill_in 'Name',             with: 'Foo bar'
  fill_in 'Email',            with: 'foo@bar.com'
  fill_in 'Password',         with: 'foo'
  fill_in 'Password confirmation', with: 'bar'

  click_button 'Save changes'
end

ならば(/^入力を反映しない/) do
  expect(page).to have_title('Edit user')
  expect(@user.reload.name).to eq(@user.name)
  expect(@user.reload.email).to eq(@user.email)
end

前提(/^ユーザーがログイン済みで、ユーザー編集画面に訪問した。$/) do
  @user = FactoryGirl.create(:michael)

  visit login_path

  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password

  click_button 'Log in'

  visit edit_user_path(@user)
end

もし(/^入力内容が問題なかった$/) do
  visit edit_user_path(@user)

  expect(page).to have_title('Edit user')

  fill_in 'Name',             with: 'Foo bar'
  fill_in 'Email',            with: 'foo@bar.com'
  fill_in 'Password',         with: ''
  fill_in 'Password confirmation', with: ''
  choose 'user_notification_option_false'

  click_button 'Save changes'
end

ならば(/^入力を反映し、Profile updateを表示する/) do
  expect(@user.reload.name).to eq('Foo bar')
  expect(@user.reload.email).to eq('foo@bar.com')
  expect(@user.reload.notification_option).to be_falsey

  expect(page).to have_content('Profile update')
end
