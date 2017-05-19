class Api::V1::UsersController < ApplicationController
  def index
    @users = User.all

    render 'index', formats: 'json', handlers: 'jbuilder'
  end

  def show
    @user = User.find(params[:id])

    render 'show', formats: 'json', handlers: 'jbuilder'
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
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      render formats: 'json', notice: 'Successfully updated.'
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    User.find(params[:id]).destroy

    head :no_content
  end

  private

    def user_params
      params.permit(:name, :email, :password, :password_confirmation)
    end
end
