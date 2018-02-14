class PagesController < ApplicationController

    def home
        @favorites = []
        if logged_in? && !current_user.favorites.empty?
            current_user.favorites.each do |favorite|
                topic = Topic.find_by(name: favorite.name)
                topic_articles = NewsApi.new.get_news_for_topic(url_param: topic.url_param)
                favorite = {topic: topic, topic_articles: topic_articles }
                @favorites << favorite
            end
        else
            topic = Topic.find_by(route: 'top-news')
            topic_articles = NewsApi.new.get_news_for_topic(url_param: topic.url_param)
            favorite = {topic: topic, topic_articles: topic_articles }
            @favorites << favorite
        end
    end

end
