class SearchController < ApplicationController
  def search
    if params[:q].nil?
      @articles = []
    else
      @articles = Article.search params[:q]
    end
  end

  def normal_search
    @key_word = params[:q]
    if params[:q].nil?
      @articles = []
    else
      @articles = Article.normal_search params[:q]
    end
  end
end
