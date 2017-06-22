class UsersController < ApplicationController
  def new
  	render template: "users/new"
  end

  def show
  	@user = User.find(params[:id])
  end
end
