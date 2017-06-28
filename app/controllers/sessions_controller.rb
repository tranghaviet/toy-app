# read more: http://www.justinweiss.com/articles/how-rails-sessions-work/
class SessionsController < ApplicationController
  def new
    # If we don't use ifelse statement
    # Rails will automatic render template: 'sessions/new'
    if logged_in? # already login
      flash[:info] = 'Your already logged in'
      redirect_to root_path
    else
      render template: 'sessions/new' # Login view
    end
  end
  
  # Create a new session when log in
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message = 'Account not activated.'
        message += 'Please check your email for the activation link.'
        flash[:warning] = message
        redirect_to login_path
      end
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
