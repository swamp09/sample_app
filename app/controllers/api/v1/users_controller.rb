class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

 # before_action :authenticate

  def index
    @users = User.all

    render formats: 'json'
  end

  def show
    render status: :not_found unless @user

    render formats: 'json'
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email

      render formats: 'json', status: :created, notice: 'Successfully created.'
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update_attributes(user_params)
      render formats: 'json', notice: 'Successfully updated.'
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy

    head :no_content
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.permit(:name, :email, :password, :password_confirmation)
    end

    def authenticate
      authenticate_or_request_with_http_token do |token|
        @user = User.where(auth_token: token).where('auth_token_created_at >= ?', 1.day.ago).first
      end
    end
end
