step 'ユーザーがログイン済みである、ルームが作成されている' do
  @user = create(:michael)
  @other = create(:archer)
  @room = create(:room)

  @room.create_room(@user, @other)

  visit login_path

  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password

  click_button 'Log in'
end

step 'ルーム一覧画面に訪問する' do
  visit rooms_path

  expect(page).to have_title('Message Rooms')
end

step 'ルームの一覧が表示されている' do
  @user.rooms.each do |room|
    expect(page).to have_link(room.users[0].at_nickname)
  end
end

step 'ユーザーがログイン済みである' do
  @user = create(:michael)

  visit login_path

  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password

  click_button 'Log in'
end

step 'ルーム一覧画面に訪問する' do
  visit rooms_path

  expect(page).to have_title('Message Rooms')
end

step ':fieldフォームに:valueと入力する' do |field, value|
  fill_in field, with: value
end

step ':textをクリックする' do |text|
  click_button text
end

step ':textと出力される' do |text|
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

step 'ルーム一覧画面に訪問する' do
  visit rooms_path

  expect(page).to have_title('Message Rooms')
end

step ':fieldフォームに:valueと入力する' do |field, value|
  fill_in field, with: value
end

step ':textをクリックする' do |text|
  click_button text
end

step ':textと出力される' do |text|
  expect(page).to have_content(text)
end


step 'ユーザーがログイン済みである,ユーザーと"archer"は相互フォロー済みである' do
  @user = create(:michael)
  @other = create(:archer)

  @user.follow(@other)
  @other.follow(@user)

  visit login_path

  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password

  click_button 'Log in'
end

step 'ルーム一覧画面に訪問する' do
  visit rooms_path

  expect(page).to have_title('Message Rooms')
end

step ':fieldフォームに:valueと入力する' do |field, value|
  fill_in field, with: value
end

step ':textをクリックする' do |text|
  click_button text
end

step '作られたルームに遷移している' do
  expect(page).to have_title('Message Room')
end

step 'ユーザーがログイン済みである、ルームが作成されている' do
  @user = create(:michael)
  @other = create(:archer)
  @room = create(:room)

  @room.create_room(@user, @other)

  visit login_path

  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password

  click_button 'Log in'
end

step 'ルーム一覧画面に訪問する' do
  visit rooms_path

  expect(page).to have_title('Message Rooms')
end

step 'ルームの一覧が表示されている' do
  @user.rooms.each do |room|
    expect(page).to have_link(room.users[0].at_nickname)
  end
end

step 'ルームを選択する' do
  click_link @room.users[0].at_nickname + " " + @room.users[1].at_nickname
end

step 'ルームを表示する' do
  expect(page).to have_title('Message Room')
end

