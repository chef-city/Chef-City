require 'spec_helper'

describe UsersController  do
  it "should successfully create a valid user" do
    xhr :post, :create, :user=>{:email=>'test@email.com', :password=>'passsword'}

    User.all.count.should == 1
  end

  it "should notify user if unable to create account" do
    xhr :post, :create, :user=>{:password=>'pass'}
    User.all.count.should == 0
  end

  it "should create a session with successful login" do
    user = User.create(:email=>'email@test.com', :password=>'password')
    user.save
    back_page = 'http://www.test.com'
    request.env["HTTP_REFERER"] = back_page
    post :login, :user=>{:email=>user.email, :password=>'password'}
    session[:user].should == user.id
    response.should redirect_to(back_page)
  end

  it "should clear the session on logout" do
    user = User.create(:email=>'test@email.com', :password=>'password')
    user.save
    back_page = 'http://www.test.com'
    request.env["HTTP_REFERER"] = back_page
    session[:user] == user.id
    post :logout, :user=>{:email=>user.email, :password=>'password'}
    session.empty?.should be_true
  end
end
