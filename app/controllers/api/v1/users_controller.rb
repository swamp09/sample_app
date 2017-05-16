class Api::V1::UsersController < ApplicationController
  def index
    @users = User.all

    @users = @users.map {|user| {id: user.id, name: user.name, email: user.email} }

    render json: @users
  end

  def show
    @user = User.find(params[:id])

    @user = {id: @user.id, name: @user.name, email: @user.email}

    render json: @user
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :notification_option)
  end
end
