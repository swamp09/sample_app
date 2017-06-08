class Api::V1::SessionsController < ApplicationController
  def create
    puts 'rege be'
    puts User.first.id

    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      return render json: @user.errors, status: :unauthorized unless @user.activated?

      @user.regenerate_auth_token

      @user.touch(:auth_token_created_at)

      render formats: 'json'
      puts 'rege af'
      puts User.first.id
    else
      render json: {error: 'invalid_email'}, status: :unauthorized
    end
  end

  def destroy
    @user = User.find_by(auth_token: params[:auth_token])

    @user.update_attribute(:auth_token, nil)

    @user.touch(:auth_token_created_at)

    head :ok
  end
end
