class MicropostsController < ApplicationController
  include SessionsHelper
  before_action :login_user?

  def create
    @micropost = current_user.microposts.build(micro_params)
    if @micropost.save
      flash[:notice] = "コメントを投稿しました"
    else
      session[:micropost] = @micropost.slice(*micro_params.keys)
      flash[:danger] = @micropost.errors.full_messages
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @micropost = Micropost.find(params[:id])
    if @micropost.user_id == current_user.id
      @micropost.destroy
      flash[:notice] = "コメントを削除しました"
    else
      flash[:notice] = "コメントを削除できませんでした"
    end
    redirect_back(fallback_location: root_path, status: :see_other)
  end
end

private

def micro_params
  params.require(:micropost).permit(:user_id, :store_id, :title, :content)
end

def login_user?
  redirect_back(fallback_location: root_path) unless logged_in?
end
