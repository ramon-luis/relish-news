class TopicsController < ApplicationController

  # only want to show -> users do not get to add, update, or delete topics
  def show
    @topic = Topic.find_by(route: params["route"])
    @articles = NewsApi.new.get_news(is_query: @topic.is_query, url_param: @topic.url_param)
  end

end
