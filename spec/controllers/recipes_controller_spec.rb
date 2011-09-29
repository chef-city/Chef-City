require 'spec_helper'

describe RecipesController  do
  it "should get all recipes by default" do
    Recipe.create!(:name=>'Recipe1', :contents=>'1 cup of sugar')
    Recipe.create!(:name=>'Recipe2', :contents=>'2 cups of sugar')
    all_recipes = Recipe.all
    get :index
    assigns(:recipes).should == all_recipes
  end

  it "should create a new recipe with valid parameters" do
    recipe_title = 'name'
    recipe_contents = 'contents'
    xhr :post, :create, :recipe=>{:name=>recipe_title, :contents=>recipe_contents}
    Recipe.where(:name=>recipe_title, :contents=>recipe_contents).count.should == 1
  end
end