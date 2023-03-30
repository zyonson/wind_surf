class FavoritesController < ApplicationController
  before_action :set_store
  def create
    @favorite = Favorite.create(user_id: current_user.id, store_id: @store.id)
    flash[:notice] = "お気に入り登録しました"
    redirect_to store_path(set_store)
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, store_id: @store.id)
    @favorite.destroy
    flash[:notice] = "お気に入り削除しました"
    redirect_to store_path(set_store)
  end
end

private

def set_store
  @store = Store.find(params[:store_id])
end
