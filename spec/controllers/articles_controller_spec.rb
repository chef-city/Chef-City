require 'spec_helper'

describe ArticlesController  do
  it "should create a new article with proper parameters" do
    title = 'name'
    content = 'contents'
    xhr :post, :create, :article=>{:title=>title, :content=>content}
    Article.where(:title=>title, :content=>content).count.should == 1
  end

  it "should get all articles by default" do
    Article.create!(:title=>'Blog Post 1', :content=>'bloggy!')
    Article.create!(:title=>'Blog Post 2', :content=>'blog!')
    all_articles = Article.all
    get :index
    assigns(:articles).should == all_articles
  end
end