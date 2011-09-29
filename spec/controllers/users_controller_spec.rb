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
    user = User.create!(:email=>'email@test.com', :password=>'password')
    post :login, :user=>{:email=>user.email, :password=>user.password}
    session[:user].should == user.id
  end
end
