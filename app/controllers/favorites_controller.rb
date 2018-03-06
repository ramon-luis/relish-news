class FavoritesController < ApplicationController

  # manages user favorites: CRUD
  # a user can favorite a topic (or search)

  # show all favorites for a user
  def index
    if logged_in?
      @user = current_user
      @favorites = @user.favorites
    else
      redirect_to "/"
    end
  end

  # create a favorite for a user
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

    # make sure ranking number is in successive order from 1 to highest value
    normalize_rank(current_user.favorites)
    flash.now[:success] = 'Added to your favorites'
    redirect_back fallback_location: root_path
  end

  # increase the rank of a favorite for a user
  def uprank
    favorite = Favorite.find_by(id:params['id'])
    @user = current_user
    @favorites = @user.favorites
    move_favorite_up(@favorites, favorite)
    normalize_rank(@favorites)
    redirect_back fallback_location: root_path
  end

  # decrease the rank of a favorite for a user
  def downrank
    favorite = Favorite.find_by(id:params['id'])
    @user = current_user
    @favorites = @user.favorites
    move_favorite_down(@favorites, favorite)
    normalize_rank(@favorites)
    redirect_back fallback_location: root_path
  end

  # delete a user favorite
  def destroy
    favorite = Favorite.find_by(id: params['id'])
    favorite.delete
    redirect_to '/favorites'
  end

end
