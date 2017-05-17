class Api::V1::UsersController < ApplicationController
  def index
    @users = User.all

    render 'index', formats: 'json', handlers: 'jbuilder'
  end

  def show
    @user = User.find(params[:id])

    render 'show', formats: 'json', handlers: 'jbuilder'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :notification_option)
  end
end
