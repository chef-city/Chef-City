require 'spec_helper'

describe User do
  it "does not allow duplicate emails" do
    email = 'test@email.com'
    orig_user = User.create! ({:email=>email, :password=>'password'})
    second_user = User.create ({:email=>email, :password=>'password'})
    second_user.save.should be_false
  end

  it "requires an email address" do
    user = User.create ({:password=>'password'})
    user.save.should be_false
  end

  it "correctly encrypts the password" do
    user = User.create!(:email=>'email@test.com', :password=>'password')
    user.password.should_not  == 'email@test.com'
  end
end
