class PagesController < ApplicationController
  def home
    @usNews = NewsApi.new.usNews['articles']
  end
end
