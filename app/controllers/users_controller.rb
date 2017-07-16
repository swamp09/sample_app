class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[index edit update destroy following followers]
  before_action :correct_user, only: %i[edit update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.search(params[:search]).page(params[:page])
    @title = if params[:search].blank?
               'All users'
             else
               'Search result'
             end

    respond_to do |format|
      format.html
      format.json { render json: @users.to_json }
    end
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = 'Please check your email to activate your account.'
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile update'

      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy

    flash[:success] = 'User deleted'

    redirect_to users_url
  end

  def following
    @title = 'Following'
    @user  = User.find(params[:id])

    @users = @user.following.page(params[:page])

    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @user  = User.find(params[:id])

    @users = @user.followers.page(params[:page])

    render 'show_follow'
  end

  def auto_complete
    @users = if params[:term] =~ /(@[^\s]+)\s.*/
             elsif user_nickname = params[:term].match(/(@[^\s]+)/)
               users = User.select('nickname').where('nickname LIKE ? AND activated = ?', "%#{user_nickname[1].to_s[1..-1]}%", true)

               users.map {|user| {nickname: '@' + user.nickname} }
             end
    render json: @users.to_json
  end

  private

  def user_params
    params.require(:user).permit(:name, :nickname, :email, :password, :password_confirmation, :notification_option)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
