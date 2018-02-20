class NewsController < ApplicationController

  def show

    @search_term = params[:q]
    query_param = CGI.escape(@search_term)
    @articles = NewsApi.new.get_news(is_query: true, url_param: query_param)

    @show_save_to_favorites_button = false

    if logged_in?
      # get the user and favorites
      @user = current_user
      favorites = @user.favorites

      # assume search_term not an existing favorite or an existing topic
      is_existing_favorite = false
      @is_existing_topic = false
      @topic_id = nil

      # check is search_term is an existing topic and favorite
      if topic = Topic.where('lower(name) = ?', @search_term.downcase).first
        @is_existing_topic = true
        @topic_id = topic[:id]
        is_existing_favorite = favorites.where(topic_id: topic[:id]).exists?
      else
        is_existing_favorite = false
      end

      # set if the save to favorites button should be shown
      @show_save_to_favorites_button = !is_existing_favorite
      @rank = favorites.length + 1
    end
  end

end
