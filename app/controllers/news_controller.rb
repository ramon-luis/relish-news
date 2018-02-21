class NewsController < ApplicationController

  def home
    # array to store headline sections
    @headline_sections = []

    # get the user favorites if user is logged in and has favorites
    if logged_in? && !current_user.favorites.empty?
        @user = current_user
        current_user.favorites.order(:rank).each do |favorite|
            topic = Topic.find_by(id: favorite.topic_id)
            articles = NewsApi.new.get_news(is_query: topic.is_query, url_param: topic.url_param)
            headline_section = { favorite: favorite, topic: topic, articles: articles }
            @headline_sections << headline_section
        end
    else
        # just use top-news for headline (not logged in or no user favorites)
        topic = Topic.find_by(route: 'top-news')
        articles = NewsApi.new.get_news(is_query: false, url_param: topic.url_param)
        headline_section = { favorite: nil, topic: topic, articles: articles }
        @headline_sections << headline_section
    end
  end


  def show
    # check if user passed a search
    is_search = params.has_key?(:q)

    # define topic, search_term, query status, url_param
    if is_search
      # should have been passed a search term
      @search_term = (params[:q].nil? || params[:q].empty?) ? 'Top News' : params[:q]
      @topic = Topic.where('lower(name) = ?', @search_term.downcase).first
      is_query = true
      url_param = CGI.escape(@search_term)
      @title = "Search results for: #{@search_term}"
    else
      # should have been passed a route
      @topic = Topic.find_by(route: params["route"])
      @search_term = nil
      is_query = @topic.is_query
      url_param = @topic.url_param
      @title = @topic.name
    end

    # get the articles
    @articles = NewsApi.new.get_news(is_query: is_query, url_param: url_param)

    # default is to hide the save to favorites button
    @show_save_to_favorites_button = false

    # set variables if user is logged in
    if logged_in?
      @user = current_user
      @is_existing_topic = !@topic.nil?
      @show_save_to_favorites_button = !@is_existing_topic || !@user.favorites.where(topic_id: @topic.id).exists?
      @topic_id = @is_existing_topic ? @topic.id : nil
      @rank = @user.favorites.length + 1
    end
  end


end
