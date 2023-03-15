class StoresController < ApplicationController
  before_action :admin_user!, except: [:index, :show, :search]
  include SessionsHelper
  def index
    @allstores = Store.all
  end

  def show
    @store = Store.find(params[:id])
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

  def search
    search_method
  end
end

private

def admin_user!
  redirect_to stores_path unless current_user.admin?
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

def search_methoad
  @stores = if params[:title_search].present?
              Store.where("store_name LIKE ? OR prefecture LIKE ?", "%#{params[:title_search]}%",
                          "%#{params[:title_search]}%").order(created_at: :desc)
            else
              []
            end
  search_methoad1
end

def search_methoad1
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
