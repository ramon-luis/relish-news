class TopicsController < ApplicationController



  # only want to show -> users do not get to add, update, or delete topics
  def show
    @topic = Topic.find_by(route: params["route"])
    @articles = NewsApi.new.get_news_for_topic(url_param: @topic.url_param)
  end

end
