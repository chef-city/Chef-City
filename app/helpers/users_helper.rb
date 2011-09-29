module UsersHelper
  def current_user
    if session[:user]
      @current_user ||= User.find(session[:user])
    else
      false
    end
  end
end
