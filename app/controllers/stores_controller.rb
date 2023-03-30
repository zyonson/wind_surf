class StoresController < ApplicationController
  before_action :admin_user!, except: [:index, :show, :search, :main, :searchstore]

  def main; end

  def searchstore
    @stores = Store.with_attached_image.where("store_name LIKE ? OR prefecture LIKE ?", "%#{params[:store_search]}%",
                                              "%#{params[:store_search]}%")
    flash[:notice] = if @stores.nil?
                       "検索結果は０件です"
                     else
                       "検索結果は#{@stores.count}件です"
                     end
  end

  def index
    @allstores = Store.with_attached_image
  end

  def show
    @store = Store.find(params[:id])
    @microposts = @store.microposts
    @micropost = Micropost.new
    return unless logged_in?

    @favorite = Favorite.where(store_id: @store.id, user_id: current_user.id)
  end

  def new
    @store = Store.new(session[:store] || {})
  end

  def create
    @store = Store.new(store_params)
    image_check
    if @store.save
      session[:store] = nil
      flash[:success] = "create new store"
      redirect_to stores_path
    else
      create_faile
    end
  end

  def edit
    @store = Store.find(params[:id])
  end

  def update
    @store = Store.find(params[:id])
    if @store.update(store_params)
      flash[:success] = 'update!'
      redirect_to @store
    else
      flash[false] = 'failer update'
      redirect_to edit_store_path
    end
  end

  def destroy
    @store = Store.find(params[:id]).destroy
    flash[:success] = "delete store"
    redirect_to stores_path status: :see_other
  end

# rubocop:disable all
  def search
    @stores = if params[:title_search].present?
                Store.where("store_name LIKE ? OR prefecture LIKE ?", "%#{params[:title_search]}%",
                            "%#{params[:title_search]}%").order(created_at: :desc)
              else
                []
              end
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update('search_results',
                              partial: 'stores/search_results',
                              locals: { stores: @stores })
        ]
      end
    end
  end
end
# rubocop:enable all

private

def admin_user!
  redirect_to stores_path unless logged_in? && current_user.admin?
end

def store_params
  params.require(:store).permit(:store_name, :address, :phone_number, :boat_house, :price, :day, :time, :prefecture,
                                :image)
end

def image_check
  return if @store.image.attached?

  @store.image.attach(io: File.open(
    Rails.root.join('app', 'assets', 'images', 'default_store.jpg')
  ), filename: 'default_store.jpg')
end

def create_faile
  session[:store] = @store.attributes.slice(*store_params.keys)
  flash[:danger] = @store.errors.full_messages
  redirect_to new_store_path
end
