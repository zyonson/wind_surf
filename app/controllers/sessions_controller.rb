class SessionsController < ApplicationController
  include SessionsHelper
  def new; end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user&.authenticate(params[:session][:password])
      reset_session
      log_in @user
      flash[:success] = "login success"
      redirect_to @user
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
