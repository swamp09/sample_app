step 'ユーザーがログイン済みである、ルームを表示している' do
  @user = create(:michael)
  @other = create(:archer)
  @room = create(:room)

  @room.create_room(@user, @other)

  visit login_path

  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password

  click_button 'Log in'

  visit room_path @room
end

step ':fieldフォームに:valueと入力し、enterを押す' do |field, value|
  fill_in field, with: value
  find('#message').send_keys(:enter)
end

step ':textが画面に反映される' do |text|
  expect(page).to have_content(text)
end

step 'ユーザーがログイン済みである、ルームを表示している' do
  in_browser(:michael) do
    Capybara.current_driver = :poltergeist

    @user = create(:michael)
    @other = create(:archer)
    @room = create(:room)

    @room.create_room(@user, @other)

    visit login_path

    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password

    click_button 'Log in'

    visit room_path @room
  end
end

step '他のユーザーもルームを表示している' do
  in_browser(:archer) do
    visit login_path

    fill_in 'Email', with: @other.email
    fill_in 'Password', with: @other.password

    click_button 'Log in'

    visit room_path @room
  end
end

step ':fieldフォームに:valueと入力し、enterを押す' do |field, value|
  in_browser(:michael) do
    fill_in field, with: value
    find('#message').send_keys(:enter)
  end
end

step ':textが画面に反映される' do |text|
  in_browser(:michael) do
    expect(page).to have_content(text)
  end
end

step ':textが他のユーザーの画面にも反映されている' do |text|
  in_browser(:archer) do
    expect(page).to have_content(text)
  end
end
