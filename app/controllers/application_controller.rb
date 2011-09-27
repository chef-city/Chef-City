class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all

  private
  def login_required
    if !session[:user]
      redirect_to login_path
      false
    end
  end
end
