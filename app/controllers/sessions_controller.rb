# read more: http://www.justinweiss.com/articles/how-rails-sessions-work/
class SessionsController < ApplicationController
  def new
    # If we don't use ifelse statement
    # Rails will automatic render template: 'sessions/new'
    if logged_in?
      redirect_to root_path
    else
      render template: 'sessions/new'
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
