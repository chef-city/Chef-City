class UsersController < ApplicationController
  respond_to :js, :html
  
  def create
    @user = User.new(params[:user])
    if @user.save
      @login_status = "Success!"
    else
      @login_status = "Something went wrong! Please try again later!"
    end
    respond_with(@login_status, :layout=> !request.xhr?)   
  end


  def new
    @user = User.new   
  end


  def login
    if request.post? and params[:email]
      @current_user = User.where(:email => params[:email]).first
      logger.debug "email: #{params[:email]} current_user id: #{@current_user.id}"
      if @current_user and @current_user.password_matches?(params[:password])
        session[:user] = @current_user.id
      else
        flash[:notice] = "Wrong email/password combination. Please try again."
      end

      logger.debug "login set session id to #{session[:user]}"
      redirect_to :back
    end
  end

  def logout
    if session[:user]
      reset_session
    end
    redirect_to :back
  end
end
