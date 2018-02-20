class PagesController < ApplicationController

    def home
        @headline_sections = []
        if logged_in? && !current_user.favorites.empty?
            @user = current_user
            current_user.favorites.order(:rank).each do |favorite|
                topic = Topic.find_by(id: favorite.topic_id)
                articles = NewsApi.new.get_news(is_query: topic.is_query, url_param: topic.url_param)
                headline_section = { favorite: favorite, topic: topic, articles: articles }
                @headline_sections << headline_section
            end
        else
            topic = Topic.find_by(route: 'top-news')
            articles = NewsApi.new.get_news(is_query: false, url_param: topic.url_param)
            headline_section = { favorite: nil, topic: topic, articles: articles }
            @headline_sections << headline_section
        end
    end

end
