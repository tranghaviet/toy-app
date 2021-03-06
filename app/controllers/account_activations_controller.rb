class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:format])
      user.activate
      log_in user
      flash[:success] = 'Your account is activated.'
      redirect_to user
    else
      flash[:danger] = 'Invalid activation link'
      redirect_to signup_path
    end
  end
end
