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
    normalize_rank(current_user.favorites)
    redirect_to '/favorites'
  end

  def uprank
    favorite = Favorite.find_by(id:params['id'])
    @user = current_user
    @favorites = @user.favorites
    move_favorite_up(@favorites, favorite)
    normalize_rank(@favorites)
    redirect_to '/favorites'
  end

  def downrank
    favorite = Favorite.find_by(id:params['id'])
    @user = current_user
    @favorites = @user.favorites
    move_favorite_down(@favorites, favorite)
    normalize_rank(@favorites)
    redirect_to '/favorites'
  end


  def destroy
    favorite = Favorite.find_by(id: params['id'])
    favorite.delete
    redirect_to '/favorites'
  end


end
