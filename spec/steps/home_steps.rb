step 'ユーザーがログイン済みである' do
  @user = create(:michael)

  visit login_path

  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password

  click_button 'Log in'
end

step 'ホーム画面に訪問する' do
  visit root_path

  expect(page).to have_title('Home')
end

step ':fieldフォームに:valueと入力する' do |field, value|
  fill_in field, with: value
end

step ':textボタンをクリックする' do |text|
  click text
end

step ':textが新しくfeedに追加されている' do |text|
  expect(page).to have_content(text)
end

step 'ユーザーがログイン済みである' do
  @user = create(:michael)
  @other = create(:archer)

  visit login_path

  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password

  click_button 'Log in'
end

step 'マイクロポストを投稿済みである' do
  @micropost = @user.microposts.create(attributes_for(:orange))
  @micropost = @user.microposts.create(attributes_for(:tau_manifesto))
end

step '他のユーザーをフォローしている' do
  @user.follow(@other)
end

step 'ホーム画面に訪問する' do
  visit root_path

  expect(page).to have_title('Home')
end

step 'マイクロポスト一覧を表示する' do
  @feed_items = current_user.feed.page(params[:page])

  @feed_items.each do |micropost|
    expect(page).to have_content(micropost.content)
  end
end

step 'ユーザーがログイン済みである' do
  @user = create(:michael)
  @other = create(:archer)

  visit login_path

  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password

  click_button 'Log in'
end

step 'マイクロポストを投稿済みである' do
  @micropost = @user.microposts.create(attributes_for(:orange))
  @micropost = @user.microposts.create(attributes_for(:tau_manifesto))
end

step '他のユーザーをフォローしている' do
  @user.follow(@other)
end

step 'ホーム画面に訪問する' do
  visit root_path

  expect(page).to have_title('Home')
end

step ':fieldフォームに:valueと入力する' do |field, value|
  fill_in field, with: value
end

step ':textボタンをクリックする' do |text|
  click text
end

step ':textに一致するマイクロポストを表示する' do |text|
  expect(page).to have_content(text)
end

step '検索に一致しないものは表示していない' do
  expect(page).to_not have_content('Check out the @tauday site by @mhartl: http://tauday.com')
end

step 'ユーザーがログイン済みである' do
  @user = create(:michael)
  @other = create(:archer)

  visit login_path

  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password

  click_button 'Log in'
end

step 'ホーム画面に訪問する' do
  visit root_path

  expect(page).to have_title('Home')
end

step ':fieldフォームに:valueと入力する' do |field, value|
  fill_in field, with: value
end

step ':textボタンをクリックする' do |text|
  click text
end

step ':textが新しくfeedに追加されている' do |text|
  expect(page).to have_content(text)
end

step 'archerがログインする' do
  visit login_path

  fill_in 'Email', with: @other.email
  fill_in 'Password', with: @other.password

  click_button 'Log in'
end

step 'ホーム画面に訪問する' do
  visit root_path

  expect(page).to have_title('Home')
end

step ':textがfeedに表示されている' do |text|
  expect(page).to have_content(text)
end
