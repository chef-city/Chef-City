class ApplicationController < ActionController::Base
  before_filter :current_user
  protect_from_forgery
  helper :all


  private
  def login_required
    if !session[:user]
      redirect_to login_path
      false
    end
  end

  def current_user
    logger.debug "running current_user session[:user] #{session[:user]}"
    if session[:user]
      @current_user ||= User.find(session[:user])
    else
      false
    end
  end
end
