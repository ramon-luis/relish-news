class FavoritesController < ApplicationController

  def create
    favorite = Favorite.new(name: params[:name], rank: params[:rank], user_id: params[:user_id])
    favorite.save
    redirect_to '/profile'
  end


end
