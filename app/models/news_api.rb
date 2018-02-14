require 'uri'
require 'open-uri'
require 'json'

class NewsApi

  NEWSAPI_URI = 'https://newsapi.org/v2/'
  TOP_HEADLINES = 'top-headlines?language=en&sortBy=popularity'
  EVERYTHING = 'everything?language=en&sortBy=popularity'
  API_KEY = 'apiKey=4b685ee819764643b10ccbe6e533d1fd'

  # can not mix country & sources
  STANDARD_TOPICS = { :espn => { name: "ESPN", route: "espn", url_param: "sources=espn" },
                      :cnn => { name: "CNN", route: "cnn", url_param: "sources=cnn" },
                      :top_news => { name: "Top News", route: "top-news", url_param: "country=us" },
                      :business => { name: "Business", route: "business", url_param: "country=us&category=business" } }

  # for reference to manipulate url_params
  CATEGORY_OPTIONS = ['business', 'entertainment', 'general', 'health', 'science', 'sports', 'technology']
  SORT_BY_OPTIONS = ['relevancy', 'popularity', 'publishedAt']

  def get_url(url_param:)
    fromDay = Date.today - 2
    url = "#{NEWSAPI_URI}#{TOP_HEADLINES}&#{url_param}&from=#{fromDay}&#{API_KEY}"
  end

  def get_news_for_topic(url_param:)
    fromDay = Date.today - 2
    url = "#{NEWSAPI_URI}#{TOP_HEADLINES}&#{url_param}&from=#{fromDay}&#{API_KEY}"
    getarticlesJSON(url)
  end

  def get_news_for_query(query_param:)
    fromDay = Date.today - 2
    url = "#{NEWSAPI_URI}#{EVERYTHING}&q=#{topic_query}&from=#{fromDay}&#{API_KEY}"
    getarticlesJSON(url)
  end

private

  def getarticlesJSON(url)
    bufferAsString = open(url).read
    parsedArray = JSON.parse(bufferAsString)
    articlesJSON = parsedArray['articles']
  end

end
