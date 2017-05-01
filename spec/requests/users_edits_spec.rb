require 'rails_helper'

RSpec.describe 'UsersEdits', type: :request do
  before do
    @user = create(:michael)
  end
  describe 'GET /users_edits' do
    let(:name) { 'Foo bar' }
    let(:email) { 'foo@bar.com' }

    before do
      login_button(@user)
      visit edit_user_path(@user)
    end

    describe 'unsuccessful edit' do
      it do
        expect(page).to have_title('Edit user')

        patch user_path(@user), params: {user: {name: '',
                                                email: 'foo@invalid', password: 'foo',
                                                password_confirmation: 'bar'}}

        expect(page).to have_title('Edit user')
      end
    end

    describe 'successfull edit' do
      let(:name) { 'Foo bar' }
      let(:email) { 'foo@bar.com' }

      before do
        fill_in 'Name',             with: name
        fill_in 'Email',            with: email
        fill_in 'Password',         with: ''
        fill_in 'Password confirmation', with: ''

        click_button 'Save changes'
      end

      it do
        expect(@user.reload.name).to eq(name)
        expect(@user.reload.email).to eq(email)
      end
    end

    describe 'successful edit with friendly forwarding' do
      subject do
        patch user_path(@user), params: {user: {email: name,
                                                password: email}}
      end

      before do
        fill_in 'Name',             with: name
        fill_in 'Email',            with: email
        fill_in 'Password',         with: ''
        fill_in 'Password confirmation', with: ''

        click_button 'Save changes'
      end

      it do
        get edit_user_path(@user)

        expect(flash).to_not be_nil

        expect(subject).to redirect_to(login_url)

        expect(@user.reload.name).to eq(name)
        expect(@user.reload.email).to eq(email)
      end
    end
  end
end
