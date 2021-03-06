class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  http_basic_authenticate_with name: 'user', password: Settings.secret_pass

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
    params.permit(:name, :nickname, :email, :password, :password_confirmation)
  end
end
