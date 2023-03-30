class SessionsController < ApplicationController
  before_action :log_ina, only: :edit
  before_action :login_user, only: :new
  def new; end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user&.authenticate(params[:session][:password])
      success_create
    else
      flash[:danger] = "invalid email or password "
      redirect_to login_path
    end
  end

  def destroy
    log_out if logged_in?
    reset_session
    flash[:success] = "logout"
    redirect_to login_path, status: :see_other
  end
end

private

def log_ina
  redirect_to(root_url, status: :see_other) unless logged_in?
end

def login_user
  redirect_to current_user if logged_in?
end

def success_create
  reset_session
  params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
  log_in @user
  flash[:success] = "login success"
  redirect_to @user
end
