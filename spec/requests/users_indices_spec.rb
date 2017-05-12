require 'rails_helper'

RSpec.describe 'UsersIndices', type: :request do
  before do
    @admin = create(:michael)
    @non_admin = create(:archer)

    login_button user

    visit users_path
  end
end
