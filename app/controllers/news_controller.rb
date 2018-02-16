class NewsController < ApplicationController

  def show
    @search_term = params[:q]
    query_param = CGI.escape(@search_term)
    @articles = NewsApi.new.get_news_for_query(query_param: query_param)
  end

end
