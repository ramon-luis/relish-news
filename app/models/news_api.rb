require 'uri'
require 'open-uri'
require 'json'

# NewsApi class is used to pull data from newsapi.org

class NewsApi

  # constants
  NEWSAPI_URI = 'https://newsapi.org/v2/'
  TOP_HEADLINES = 'top-headlines?language=en&sortBy=popularity'
  EVERYTHING = 'everything?language=en&sortBy=popularity'
  API_KEY = "apiKey=#{ENV['API_CODE']}"

  # note: can not mix country & sources
  STANDARD_TOPICS = {
                      :top_news => { name: "Top News", is_query: false, route: "top-news", url_param: "country=us" },
                      :business => { name: "Business", is_query: false, route: "business", url_param: "country=us&category=business" },
                      :entertainment => { name: "Entertainment", is_query: false, route: "entertainment", url_param: "country=us&category=entertainment" },
                      :health => { name: "Health", is_query: false, route: "health", url_param: "country=us&category=health" },
                      :science => { name: "Science", is_query: false, route: "science", url_param: "country=us&category=science" },
                      :sports => { name: "Sports", is_query: false, route: "sports", url_param: "country=us&category=sports" },
                      :tech => { name: "Tech", is_query: false, route: "tech", url_param: "country=us&category=technology" },
                      :associated_press => { name: "Associated Press", is_query: false, route: "associated_press", url_param: "sources=associated-press" },
                      :bleacherreport => { name: "Bleacher Report", is_query: false, route: "bleacher-report", url_param: "sources=bleacher-report" },
                      :bloomberg => { name: "Bloomberg", is_query: false, route: "bloomberg", url_param: "sources=bloomberg" },
                      :cnn => { name: "CNN", is_query: false, route: "cnn", url_param: "sources=cnn" },
                      :engadget => { name: "Engadget", is_query: false, route: "engadget", url_param: "sources=engadget" },
                      :espn => { name: "ESPN", is_query: false, route: "espn", url_param: "sources=espn" },
                      :hacker_news => { name: "Hacker News", is_query: false, route: "hacker-news", url_param: "sources=hacker-news" },
                      :mashable => { name: "Mashable", is_query: false, route: "mashable", url_param: "sources=mashable" },
                      :national_geographic => { name: "National Geographic", is_query: false, route: "national-geographic", url_param: "sources=national-geographic" },
                      :nytimes => { name: "The New York Times", is_query: false, route: "the-new-york-times", url_param: "sources=the-new-york-times" },
                      :reuters => { name: "Reuters", is_query: false, route: "reuters", url_param: "sources=reuters" },
                      :tech_crunch => { name: "Tech Crunch", is_query: false, route: "tech-crunch", url_param: "sources=tech-crunch" },
                      :verge => { name: "The Verge", is_query: false, route: "the-verge", url_param: "sources=the-verge" },
                      :vice_news => { name: "Vice News", is_query: false, route: "vice-news", url_param: "sources=vice-news" },
                      }

  # for reference to manipulate url_params
  CATEGORY_OPTIONS = ['business', 'entertainment', 'general', 'health', 'science', 'sports', 'technology']
  SORT_BY_OPTIONS = ['relevancy', 'popularity', 'publishedAt']

  # header topics
  HEADER_TOPICS = ['Top News', 'Business', 'Sports', 'Tech']

  # get news for either a query or topic
  def get_news(is_query:, url_param:)
    is_query ? get_news_for_query(url_param) : get_news_for_topic(url_param)
  end

private

  # get news based on newsapi defined topic or source
  def get_news_for_topic(url_param)
    url = "#{NEWSAPI_URI}#{TOP_HEADLINES}&#{url_param}&#{API_KEY}"
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
