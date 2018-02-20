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
    # check if existing topic
    if params[:is_existing_topic] == "true"
      # save existing topic to user favorites
      favorite = Favorite.new(rank: params[:rank], topic_id: params[:topic_id], user_id: params[:user_id])
      favorite.save
    else
      # create the topic first
      topic_name = params[:new_topic_name]
      is_query = true
      url_param = CGI.escape(topic_name)
      route = url_param
      topic = Topic.new(name: topic_name, is_query: is_query, route: route, url_param: url_param)
      topic.save

      # save the new topic to user favorites
      favorite = Favorite.new(rank: params[:rank], topic_id: topic.id, user_id: params[:user_id])
      favorite.save
    end

    normalize_rank(current_user.favorites)
    flash.now[:success] = 'Added to your favorites'
    redirect_back fallback_location: root_path
  end

  def uprank
    favorite = Favorite.find_by(id:params['id'])
    @user = current_user
    @favorites = @user.favorites
    move_favorite_up(@favorites, favorite)
    normalize_rank(@favorites)
    redirect_back fallback_location: root_path
  end

  def downrank
    favorite = Favorite.find_by(id:params['id'])
    @user = current_user
    @favorites = @user.favorites
    move_favorite_down(@favorites, favorite)
    normalize_rank(@favorites)
    redirect_back fallback_location: root_path
  end


  def destroy
    favorite = Favorite.find_by(id: params['id'])
    favorite.delete
    redirect_to '/favorites'
  end


end
