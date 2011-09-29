class UsersController < ApplicationController
  respond_to :js, :html
  
  def create
    @user = User.new(params[:user])
    puts "user: #{@user.email}"
    puts "password: #{@user.password}"
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
    if request.post? and params[:user]
      @current_user = User.where(:email=>params[:user][:email]).first
      puts "user pass: #{@current_user.password}"

      if @current_user and @current_user.password_matches?(params[:user][:password])
        session[:user] = @current_user.id
      else
        flash[:notice] = "Wrong email/password combination. Please try again."
      end

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
