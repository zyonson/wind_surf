class UsersController < ApplicationController
  before_action :admin_user,     only: :destroy
  before_action :log_in_as, only: [:edit, :index]
  before_action :new_user, only: :new
  include SessionsHelper

  def index
    @users = User.with_attached_avatar
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new(session[:user] || {})
  end

  def create  # rubocop:disable all
    @user = User.new(user_params)
    avatar_check
    if @user.save
      reset_session
      log_in @user
      flash[:success] = 'create your account!'
      redirect_to @user
    else
      session[:user] = @user.attributes.slice(*user_params.keys)
      flash[:danger] = @user.errors.full_messages
      redirect_to new_user_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'your profile is update!'
      redirect_to @user
    else
      flash[:danger] = @user.errors.full_messages
      redirect_to edit_user_path
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to new_user_path status: :see_other
  end

  def search
    @users = User.where("name LIKE ? OR email LIKE?", "%#{params[:user_search]}%", "%#{params[:user_search]}%")
  end
end

private

def user_params
  params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
end

# rubocop:disable all
def avatar_check
  @user.avatar.attach(io: File.open(
    Rails.root.join('app', 'assets', 'images', 'default_icon.jpg')
  ), filename: 'default_icon.jpg') unless @user.avatar.attached?
end
# rubocop:enable all

def admin_user
  redirect_to(root_url, status: :see_other) unless current_user.admin?
end

def log_in_as
  redirect_to(login_path, status: :see_other) if current_user.nil?
end

def new_user
  redirect_to current_user if logged_in?
end
