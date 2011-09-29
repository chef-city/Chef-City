class RecipesController < ApplicationController
  respond_to :js, :html

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
  end
  
  def create
    if request.post? and params[:recipe]
      recipe = Recipe.new(params[:recipe])
      if recipe.save
        @save_status = "Success!"
      else
        @save_status = "Something went wrong! Please try again later!"
    end
      respond_with(@save_status, :layout=> !request.xhr?)  
    end
  end
end
