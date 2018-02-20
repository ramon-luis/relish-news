require 'uri'
require 'open-uri'
require 'json'

# NewsApi class is used to pull data from newsapi.org

class NewsApi

  # constants
  NEWSAPI_URI = 'https://newsapi.org/v2/'
  TOP_HEADLINES = 'top-headlines?language=en&sortBy=popularity'
  EVERYTHING = 'everything?language=en&sortBy=popularity'
  API_KEY = 'apiKey=4b685ee819764643b10ccbe6e533d1fd'

  # note: can not mix country & sources
  STANDARD_TOPICS = { :bleacherreport => { name: "Bleacher Report", is_query: false, route: "bleacher-report", url_param: "sources=bleacher-report" },
                      :bloomberg => { name: "Bloomberg", is_query: false, route: "bloomberg", url_param: "sources=bloomberg" },
                      :cnn => { name: "CNN", is_query: false, route: "cnn", url_param: "sources=cnn" },
                      :espn => { name: "ESPN", is_query: false, route: "espn", url_param: "sources=espn" },
                      :nytimes => { name: "The New York Times", is_query: false, route: "the-new-york-times", url_param: "sources=the-new-york-times" },
                      :reuters => { name: "Reuters", is_query: false, route: "reuters", url_param: "sources=reuters" },
                      :top_news => { name: "Top News", is_query: false, route: "top-news", url_param: "country=us" },
                      :business => { name: "Business", is_query: false, route: "business", url_param: "country=us&category=business" },
                      :entertainment => { name: "Entertainment", is_query: false, route: "entertainment", url_param: "country=us&category=entertainment" },
                      :health => { name: "Health", is_query: false, route: "health", url_param: "country=us&category=health" },
                      :science => { name: "Science", is_query: false, route: "science", url_param: "country=us&category=science" },
                      :sports => { name: "Sports", is_query: false, route: "sports", url_param: "country=us&category=sports" },
                      :tech => { name: "Tech", is_query: false, route: "tech", url_param: "country=us&category=technology" }}

  # for reference to manipulate url_params
  CATEGORY_OPTIONS = ['business', 'entertainment', 'general', 'health', 'science', 'sports', 'technology']
  SORT_BY_OPTIONS = ['relevancy', 'popularity', 'publishedAt']

  # # get the full url for top headlines based on a given url param
  # def get_url(url_param:)
  #   fromDay = Date.today - 2
  #   url = "#{NEWSAPI_URI}#{TOP_HEADLINES}&#{url_param}&from=#{fromDay}&#{API_KEY}"
  # end

  # get news for either a query or topic
  def get_news(is_query:, url_param:)
    is_query ? get_news_for_query(url_param) : get_news_for_topic(url_param)
  end

private

  # get news based on newsapi defined topic or source
  def get_news_for_topic(url_param)
    fromDay = Date.today - 2
    url = "#{NEWSAPI_URI}#{TOP_HEADLINES}&#{url_param}&from=#{fromDay}&#{API_KEY}"
    getarticlesJSON(url)
  end

  # search for news using a query
  def get_news_for_query(query_param)
    fromDay = Date.today - 2
    url = "#{NEWSAPI_URI}#{EVERYTHING}&q=#{query_param}&from=#{fromDay}&#{API_KEY}"
    getarticlesJSON(url)
  end

  # get the articles from newsapi.rgo
  def getarticlesJSON(url)
    bufferAsString = open(url).read
    parsedArray = JSON.parse(bufferAsString)
    articlesJSON = parsedArray['articles']
  end

end
