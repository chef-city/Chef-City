class ArticlesController < ApplicationController
  respond_to :js, :html

  def new
    @article = Article.new
  end

  def index
    @articles = Article.all
  end
  
  def create
    if request.post? and params[:article]
      article = Article.new(params[:article])
      if article.save
        @save_status = "Success!"
      else
        @save_status = "Something went wrong! Please try again later!"
    end
      respond_with(@save_status, :layout=> !request.xhr?)
    end
  end

  def show
    @article = Article.find(params[:id])
  end
end
