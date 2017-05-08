require 'rails_helper'

RSpec.describe MicropostsController, type: :controller do
  before do
    @user = create(:michael)
    @micropost = @user.microposts.create(attributes_for(:orange))
  end

  describe 'should redirect create when not logeed in' do
    it do
      subject { post micropost_path, params: {paramas: {micropost: {content: 'Lorem ipsum'}}} }

      expect { subject }.to change(Micropost, :count).by(0)
    end
  end

  describe 'should redirect destroy when not logeed in' do
    it do
      subject { delete micropost_path, params: {paramas: {micropost: {id: @micropost.id}}} }

      expect { subject }.to change(Micropost, :count).by(0)
    end
  end

  describe 'should redirect destroy for wrong micropost' do
    it do
      login_button @user

      micropost = @user.microposts.create(attributes_for(:ants))

      subject { delete micropost_path, params: {paramas: {micropost: {id: micropost.id}}} }

      expect { subject }.to change(Micropost, :count).by(0)
    end
  end
end
