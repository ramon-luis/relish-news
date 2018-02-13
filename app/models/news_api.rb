require 'uri'
require 'open-uri'
require 'json'

class NewsApi

  API_KEY = 'apiKey=4b685ee819764643b10ccbe6e533d1fd'
  NEWSAPI_URI = 'https://newsapi.org/v2/'
  TOP_HEADLINES = 'top-headlines?'
  EVERYTHING = 'everything?'
  COUNTRY = 'country=us' # there are more choices, limited for use of this app
  LANGUAGE ='language=en' # api offers more choices, limited for use of this app
  SORT_BY = 'sortBy'
  SOURCES = 'sources'
  QUERY = 'query'
  CATEGORY_OPTIONS = ['business', 'entertainment', 'general', 'health', 'science', 'sports', 'technology']
  SORT_BY_OPTIONS = ['relevancy', 'popularity', 'publishedAt']
  SOURCES_OPTIONS = {'ESPN' => 'espn', 'CNN' => 'cnn', 'Bloomberg' => 'bloomberg', 'Hacker News' => 'hacker-news'}
  PAGE_SIZE = 'pageSize=' # default is 20, max is 100
  PAGE = 'page'

  def usNews()
    url = "#{NEWSAPI_URI}#{TOP_HEADLINES}#{COUNTRY}&#{LANGUAGE}&#{API_KEY}"
    bufferAsString = open(url).read
    parsedArray = JSON.parse(bufferAsString)
  end

  def topNewsBySources(sources)
    url = "#{NEWSAPI_URI}#{TOP_HEADLINES}&#{SOURCES}=sources&#{LANGUAGE}&#{API_KEY}"
    bufferAsString = open(url).read
    parsedArray = JSON.parse(bufferAsString)
  end


end
