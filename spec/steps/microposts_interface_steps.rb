step 'ユーザーがログイン済みで' do
  @user = FactoryGirl.create(:michael)

  visit login_path

  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password

  click_button 'Log in'

  visit root_path
end

step 'マイクロポストを入力し、Postボタンを押す' do
  fill_in 'micropost_content', with: 'Lorem ipsum'
end

step 'DBに反映され作成される' do
  expect { click_button 'Post' }.to change(Micropost, :count).by(1)
end

step 'ユーザーがログイン済み' do
  @user = FactoryGirl.create(:michael)
  @micropost = @user.microposts.create(attributes_for(:orange))

  visit login_path

  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password

  click_button 'Log in'

  visit root_path
end

step 'deleteリンクが表示されている' do
  expect(page).to have_link 'delete'
end

step 'deleteリンクをクリックし、DBに反映され削除される' do
  expect { click_link 'delete' }.to change(Micropost, :count).by(-1)
end
