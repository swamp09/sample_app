step 'ユーザーがログイン済みである、マイクロポストを投稿済みである' do
  @user = create(:michael)
  @micropost = @user.microposts.create(attributes_for(:orange))

  visit login_path

  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password

  click_button 'Log in'

  visit root_path
end

step 'ユーザープロファイル画面に訪問する' do
  visit user_path(@user.id)

  expect(page).to have_title(@user.name)
end

step 'マイクロポスト一覧を表示する' do
  @microposts = @user.microposts

  @microposts.each do |micropost|
    expect(page).to have_content(micropost.content)
  end
end
