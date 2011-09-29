require 'spec_helper'

describe UsersHelper  do
  it "should return current user if someone is logged in" do
    user = User.create(:email=>'test@email.com', :password=>'password')
    user.save
    session[:user] = user.id
    current_user.id.should == user.id
  end
end