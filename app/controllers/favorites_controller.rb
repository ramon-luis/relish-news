class FavoritesController < ApplicationController

  def index
    if logged_in?
      @user = current_user
      @favorites = @user.favorites
    else
      redirect_to "/"
    end
  end


  def create
    favorite = Favorite.new(name: params[:name], rank: params[:rank], user_id: params[:user_id])
    favorite.save
    redirect_to '/favorites'
  end

  def destroy
    favorite = Favorite.find_by(id: params['id'])
    favorite.delete
    redirect_to '/favorites'
  end


end
