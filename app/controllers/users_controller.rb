class UsersController < ApplicationController
  def create
    @user = User.new(params[:user])
    if @user.save
      respond_with do |format|
        format.html do
          if request.xhr?
            render :update
          end
        end
      end
    end
  end

  def new
    
  end


  def login
    if request.post? and params[:user]
      @current_user = User.where(:email=>params[:user][:email])
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
      redirect_to :back
    end
  end
end
